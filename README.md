

Oppgave 1:
HTTP post endpunkt<br />
**https://cd0auv7ta5.execute-api.eu-west-1.amazonaws.com/Prod/generate/**

example prompt:
{
    "prompt": "beach scene"
}
<br />
workflow: **https://github.com/kyppen/PGR301DevOpsEksamen/actions/runs/11836419929**

Oppgave 2:

**https://sqs.eu-west-1.amazonaws.com/244530008913/sofa_image_queue**
<br />

Can be tested with: <br />
**aws sqs send-message --queue-url https://sqs.eu-west-1.amazonaws.com/244530008913/sofa_image_queue --message-body "cowboy"**

branch workflow: https://github.com/kyppen/PGR301DevOpsEksamen/actions/runs/11836585343/job/32981778378
merged branch into main workflow: https://github.com/kyppen/PGR301DevOpsEksamen/actions/runs/11836601771/job/32981831868
direct push to main workflow: https://github.com/kyppen/PGR301DevOpsEksamen/actions/runs/11836619471/job/32981886289

Oppgave 3:

Metode for tag generering:<br/>
**rev=$(git rev-parse --short HEAD)**<br/>
https://github.com/glennbechdevops/spring-docker-dockerhub<br/>
Methoden gjorde det enkelt å få unike tagger på alle images som ble lastet opp

SQS_QUEUE_URL:<br/>
**https://sqs.eu-west-1.amazonaws.com/244530008913/sofa_image_queue**
Docker_Image:<br/>
**kyppen/sofasqsqueue:76e2811**





