

Oppgave 1:
HTTP post endpunkt<br />
**https://cd0auv7ta5.execute-api.eu-west-1.amazonaws.com/Prod/generate/**

example prompt:
{
    "prompt": "beach scene"
}
<br />
workflow:

Oppgave 2:

**https://sqs.eu-west-1.amazonaws.com/244530008913/sofa_image_queue**
<br />

Can be tested with: <br />
**aws sqs send-message --queue-url https://sqs.eu-west-1.amazonaws.com/244530008913/sofa_image_queue --message-body "cowboy"**



