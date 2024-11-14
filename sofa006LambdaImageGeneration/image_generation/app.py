import base64
import boto3
import json
import random
import os


def lambda_handler(event, context):
    
    # Get the 'prompt' field from the body
    
    body = json.loads(event['body'])
    prompt = body['prompt']
    
    prompt_request = body.get("prompt", "Placeholder text is non is provided")
    
    ##except Exception as e:
        ##return {
        ##    "statusCode": 400,
        ##    "body": json.dumps({"message": "Error parsing the input text"})
        ##}
        
    bedrock_client = boto3.client("bedrock-runtime", region_name="us-east-1")
    s3_client = boto3.client("s3")
    
    # Define the model ID and S3 bucket name (replace with your actual bucket name)
    model_id = "amazon.titan-image-generator-v1"
    bucket_name = os.environ['BUCKET_NAME']
    
    # Frank; Important; Change this prompt to something else before the presentation with the investors!
    
    seed = random.randint(0, 2147483647)
    s3_image_path = f"5/generated_images/titan_kyp_{seed}.png"
    
    native_request = {
        "taskType": "TEXT_IMAGE",
        "textToImageParams": {"text": prompt},
        "imageGenerationConfig": {
            "numberOfImages": 1,
            "quality": "standard",
            "cfgScale": 8.0,
            "height": 1024,
            "width": 1024,
            "seed": seed,
        }
    }
    try:
        response = bedrock_client.invoke_model(modelId=model_id, body=json.dumps(native_request))
        model_response = json.loads(response["body"].read())
        
        # Extract and decode the Base64 image data
        base64_image_data = model_response["images"][0]
        image_data = base64.b64decode(base64_image_data)
        
        # Upload the decoded image data to S3
        s3_client.put_object(Bucket=bucket_name, Key=s3_image_path, Body=image_data)
        return {
            "statusCode": 200,
            "body": json.dumps({"message": "Image generated and uploaded successfully", "s3_path": s3_image_path})
        }
    except Exception as e:
        return {
            "statusCode": 69,
            "body": json.dumps({"message": "There was an issue"})
        }