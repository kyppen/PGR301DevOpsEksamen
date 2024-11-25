
### Oppgave 1:  
```
HTTP post endpunkt  
**https://cd0auv7ta5.execute-api.eu-west-1.amazonaws.com/Prod/generate/**  
{
    "prompt": "man in the bushes of love"
}    

workflow: https://github.com/kyppen/PGR301DevOpsEksamen/actions/runs/11915086655/job/33204512880 
```
### Oppgave 2:  
```
**https://sqs.eu-west-1.amazonaws.com/244530008913/sofa_image_queue**  

Can be tested with:  
aws sqs send-message --queue-url https://sqs.eu-west-1.amazonaws.com/244530008913/sofa_image_queue --message-body "cowboy"  

branch workflow: https://github.com/kyppen/PGR301DevOpsEksamen/actions/runs/12008115825/job/33470100234  
merged branch into main workflow: https://github.com/kyppen/PGR301DevOpsEksamen/actions/runs/12008166005
direct push to main workflow: https://github.com/kyppen/PGR301DevOpsEksamen/actions/runs/12008202758v
```
### Oppgave 3:  
```
Metode for tag generering:  
rev=$(git rev-parse --short HEAD)  
https://github.com/glennbechdevops/spring-docker-dockerhub  
Methoden gjorde det enkelt å få unike tagger på alle images som ble lastet opp

SQS_QUEUE_URL:  
https://sqs.eu-west-1.amazonaws.com/244530008913/sofa_image_queue 
Docker_Image:  
kyppen/sofasqsqueue:76e2811 
```

### Oppgave 4:

Det var ikke noe krav for dokumentasjon på denne oppgaven


### Oppgave 5:



**1: Automatisering og kontinuerlig levering (CI/CD): Hvordan påvirker serverless-arkitektur sammenlignet med mikrotjenestearkitektur CI/CD-pipelines, automatisering, og utrullingsstrategier?**  

Mikrotjeneste og serverless prøver å løse det samme problemet, hvordan et program splittes opp i mindre deler, skalerer og utvikles. En mikrotjeneste har mer ansvar og mer funksjonalitet enn en FaaS komponent. Dette gjør at hver mikrotjeneste krever konfigurering av OS og teknologiene som er brukt. Med en serverless arkitektur vil CSP håndtere alt av maskinvare og sikkerhetsoppdateringer. Dette frigjør utviklere til å sette søkelys på business logikken. 

I utrullingen av FaaS vil et program som terraform ofte brukes, dette gjør det mulig å lagre infrastrukturen som kode. Med en Serverless arkitektur så betaler man for å kjøre tiden som brukes, altså man kjører ikke sin egen server. dette gjør utrulling av endringer mye raskere. 

I en mikrotjeneste arkitektur så bygges hver tjeneste til en container som kan rulles ut via kubernetes. Dette krever konfigurasjon for skalering som automatisk setter opp flere tjenester der flaskehals oppstår. I en FaaS løsning kan hver komponent av systemet skalere individuelt av hverandre.  

**2: Observability (overvåkning): Hvordan endres overvåkning, logging og feilsøking når man går fra mikrotjenester til en serverless arkitektur? Hvilke utfordringer er spesifikke for observability i en FaaS-arkitektur?**  

Siden en mikrotjeneste er designet for å kjøre over lengre perioder er det naturlig å kontinuerlig logge. Dette gjøres som oftest ved å samle loggene i en tjeneste med en logging teknologi-stack som ELK. I en serverless arkitektur vil en Faas funksjon bare kjøre når den blir kallet, og derfor kan man ikke hente data kontinuerlig. Dette gjør at loggingen vil bli gjort i antall funksjonskall og kjøretid per funksjon.  

Mengden komponenter i et serverless prosjekt gjør at feilsøking blir vanskeligere. Lange pipelines og mange små deler, gjør det vanskeligere å få en god oversikt over systemet. Dette krever god konfigurasjon av verktøy som cloudwatch og X-ray for å motvirke. X-ray lar utvikler spore forespørsler som går igjennom systemet, dette hjelper med å identifisere feil i arbeidsflyten. 

**3: Skalerbarhet og kostnadskontroll: Diskuter fordeler og ulemper med tanke på skalerbarhet, ressursutnyttelse, og kostnadsoptimalisering i en serverless kontra mikrotjenestebasert arkitektur.**  

Med en mikrotjeneste-arkitektur vil kostnadene være mer forutsigbare enn med en serverless modell, der man betaler basert på faktisk bruk. Serverless er spesielt nyttig dersom tjenesten ikke brukes kontinuerlig, siden man unngår å betale for en inaktiv server. Kostnadene i serverless kan også bli uforutsigbare ved dårlig konfigurasjon eller under perioder med høy belastning. 

I en serverless applikasjon kjører alle deler av systemet uavhengig av hverandre, som gjør at systemet kan skalere presist der flaskehalsen oppstår. Dette gjør skalering i skyen svært effektivt. Et problem som kan oppstå er dersom en funksjon ikke har vært brukt på en stund, kan det ta litt tid før den blir aktivert, noe som kan påvirke responstiden. I en mikrotjeneste struktur kan man bare skalere hele moduler du kan altså ikke fokusere inn på selve delen som er tregest. Hvis en RabbitMQ-kø fylles opp, kan systemet dynamisk spinne opp en ny container som konsumerer fra køen. Denne prosessen kan ta litt tid, men den oppnår samme mål ved å håndtere økt belastning. 

Mikrotjeneste har forhåndsdefinerte ressurser, noe som gjør at de ikke kan tilpasse seg dynamisk. Serverless funksjoner, derimot, bruker bare ressursene funksjonen trenger for å kjøre, dette fører til langt mer optimalisert ressursbruk.  
 
**4: Eierskap og ansvar: Hvordan påvirkes DevOps-teamets eierskap og ansvar for applikasjonens ytelse, pålitelighet og kostnader ved overgang til en serverless tilnærming sammenlignet med en mikrotjeneste-tilnærming?**  

I en mikrotjeneste arkitektur så vil teamet har full kontroll over infrastruktur og skalering. Dette innebærer vedlikehold av systemet som sikkerhetsoppdateringer. Siden et serverless prosjekt kjører via en CSP, så tar leverandøren over all skalering, sikkerhet og vedlikehold. Dette gjør at utviklere i serverless har mindre helhetlig kontroll over systemet.  

Påliteligheten i et mikrotjenestesystem vil komme fra utvikleren sin konfigurasjon av systemet. For å oppnå høy pålitelighet i må både server konfigurasjonen og koden riktig satt opp. Serverless tar bort nødvendigheten for at utviklerne konfigurerer egne servere. 

Kostnader i et mikrotjenesteprosjekt vil kommer fra hosting av serverkostnader. Dette vil gi et mer stabilt og forutsigbare kostnader fordi tjenestene kjøres kontinuerlig. Serverless vil ha mer uforutsigbare kostnader, CSP vil fakturer basert på antar millisekunder av prosesseringstid du bruker. Kostnadskontroll vil dermed sette søkelys på å effektivisere kjøre tiden på funksjonene, kortere kjøretid betyr mindre kostnader. Et av kostnadene som kan komme med mikrotjenester er nedetid grunnet feil konfigurasjon, det er et problem teamet ikke vil ha med serverless. 

 
 

 