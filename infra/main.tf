
resource "aws_sqs_queue" "sofa_queue" {
  name                       = "sofa_image_queue"
  visibility_timeout_seconds = 30
  message_retention_seconds  = 86400
  delay_seconds              = 5
  max_message_size           = 262144

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

resource "aws_iam_role" "lambda_exec_role_sofa" {
  name = "lambda_exec_role_sofa"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_s3_policy_attach" {
  name       = "lambda_s3_policy_attach"
  roles      = [aws_iam_role.lambda_exec_role_sofa.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Check the existence of AmazonBedrockFullAccess, replace if not available
resource "aws_iam_policy_attachment" "lambda_bedrock_policy_attach" {
  name       = "lambda_bedrock_policy_attach"
  roles      = [aws_iam_role.lambda_exec_role_sofa.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonBedrockFullAccess"  # Verify this exists in your account
}

resource "aws_iam_policy_attachment" "lambda_sqs_policy_attach" {
  name       = "lambda_sqs_policy_attach"
  roles      = [aws_iam_role.lambda_exec_role_sofa.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole"
}

resource "aws_lambda_function" "sofa_image_lambda_function" {
  function_name = "sofa_image_lambda_function"
  handler       = "lambda_sqs.lambda_handler"
  runtime       = "python3.9"  # Updated runtime
  role          = aws_iam_role.lambda_exec_role_sofa.arn
  filename      = "lambda_sqs.zip"
  timeout       = "40"

  environment {
    variables = {
      BUCKET_NAME = "pgr301-couch-explorers"
    }
  }
}
resource "aws_sns_topic" "sofa_alarm_notification" {
  name = "sofa_alarm_notification"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.sofa_alarm_notification.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

resource "aws_cloudwatch_metric_alarm" "sqs_oldest_message_age" {
  alarm_name          = "sofa_alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ApproximateAgeOfOldestMessage"
  namespace           = "AWS/SQS"
  period              = 60
  statistic           = "Maximum"
  threshold           = 4 # 4 seconds
  alarm_description   = "This alarm triggers when the age of the oldest message in the SQS queue exceeds 5 minutes."
  actions_enabled     = true

  dimensions = {
    QueueName = "sofa_image_queue"
  }
  alarm_actions = [
    aws_sns_topic.sofa_alarm_notification.arn,
  ]
  
}
resource "aws_lambda_event_source_mapping" "sqs_lambda_trigger" {
  event_source_arn = aws_sqs_queue.sofa_queue.arn
  function_name    = aws_lambda_function.sofa_image_lambda_function.arn
  batch_size       = 2
}
