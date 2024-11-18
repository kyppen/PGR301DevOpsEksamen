

Oppgave 1:    
HTTP post endpunkt  
**https://cd0auv7ta5.execute-api.eu-west-1.amazonaws.com/Prod/generate/**  
```json
{
    "prompt": "man in the bushes of love"
}    
```
workflow: **https://github.com/kyppen/PGR301DevOpsEksamen/actions/runs/11836419929** 

Oppgave 2:  

**https://sqs.eu-west-1.amazonaws.com/244530008913/sofa_image_queue**  

Can be tested with:  
**aws sqs send-message --queue-url https://sqs.eu-west-1.amazonaws.com/244530008913/sofa_image_queue --message-body "cowboy"**  

branch workflow: https://github.com/kyppen/PGR301DevOpsEksamen/actions/runs/11836585343/job/32981778378  
merged branch into main workflow: https://github.com/kyppen/PGR301DevOpsEksamen/actions/runs/11836601771/job/32981831868  
direct push to main workflow: https://github.com/kyppen/PGR301DevOpsEksamen/actions/runs/11836619471/job/32981886289  

Oppgave 3:  

Metode for tag generering:  
**rev=$(git rev-parse --short HEAD)**  
https://github.com/glennbechdevops/spring-docker-dockerhub  
Methoden gjorde det enkelt å få unike tagger på alle images som ble lastet opp

SQS_QUEUE_URL:  
**https://sqs.eu-west-1.amazonaws.com/244530008913/sofa_image_queue**  
Docker_Image:  
**kyppen/sofasqsqueue:76e2811**  

Oppgave 4:


Oppgave 5. Serverless, Function as a service vs Container-teknologi


1: Automatisering og kontinuerlig levering (CI/CD)

Mikrotjenster og serverless prøver å løse det samme problemet, hvordan kan man gjøre det enklest å jobbe sammen, rulle ut kode, skalere løsningen og generelt få det til å funke.  
serverless tar prinsippende til mikrotjenster til det neste nivået. Vi separer ikke bare basert på funksjonalitet, men kan også gå så lagt at vi lager invidielle funksjoner som tjenester (lambda).  
Det vil si at en cloud provider håntere mye av komplsiteten av utrullingen av systemet, dette har gitt oss tjenster som terraform (infrastructure as code) og Lambda funksjoner.  
De vil håntere ting som oppdatering av servere, sikkerhets oppdateringer og ansvaret for at en tjenste alltid er tilgjengelig.  I Serverless vil bruker man verktøy i CI/CD på et mye høyere nivå en i mikrotjenste basert,  
mikrotjenster er bedre når man trenger mer kontrol over systemet. 

2: Observability (overvåkning)

mikrotjenster vil man kjøre i conteinere der man overfører logs enten til en tjenste hvor det lagres, eller har en mer avansert løsning som ELK stack. I serverless tar man gjerne i bruk noe som cloudwatch for å få data.  
Overvåking av mikrotjenster handler mye mer om CPU og minne, i serverless har dette mye mindre å si fordi tjenstene skalerer basert på nødvendighet, dette gjør at man får logging mye mer i form av funksjons call og ventetid.

3: Skalerbarhet og kostnadskontroll

Begge løsningene har både ulemper og fordeler i dette feltet så det er opptil utvikleren å få mest ut av løsningene.  
Serverless vil håntere all skalering for deg på bekostning at du betaler for så mye resursser som du bruker. serverless vil håntere alt av servere imot at du betaler. 