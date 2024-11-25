

Oppgave 1:  
HTTP post endpunkt  
**https://cd0auv7ta5.execute-api.eu-west-1.amazonaws.com/Prod/generate/**  
```json
{
    "prompt": "man in the bushes of love"
}    
```
workflow: **https://github.com/kyppen/PGR301DevOpsEksamen/actions/runs/11915086655/job/33204512880** 

Oppgave 2:  

**https://sqs.eu-west-1.amazonaws.com/244530008913/sofa_image_queue**  

Can be tested with:  
**aws sqs send-message --queue-url https://sqs.eu-west-1.amazonaws.com/244530008913/sofa_image_queue --message-body "cowboy"**  

branch workflow: https://github.com/kyppen/PGR301DevOpsEksamen/actions/runs/12008115825/job/33470100234  
merged branch into main workflow: https://github.com/kyppen/PGR301DevOpsEksamen/actions/runs/12008166005
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


1: Automatisering og kontinuerlig levering (CI/CD): Hvordan påvirker serverless-arkitektur sammenlignet med mikrotjenestearkitektur CI/CD-pipelines, automatisering, og utrullingsstrategier? 

Mikrotjenster og serverless prøver å løse det samme problemet, hvordan et program splittes opp i mindre deler. Vi separerer ikke bare basert på funksjonalitet, men vi kan dele opp enda mer ned til funksjoner, køer, gateways etc. Dette gjør at CI/CD prosessen ser veldig forskjellig ut. Serverless abstraktere bort nødvendigheten for kontainerbygging og server administrering. Dette forenkler pipelinen for utrulling av nye oppdateringer, og lar utvikler fokusere mer på funksjonalitet, på bekostning av helhetlig kontroll over systemet. Tjenestene i en mikrotjeneste system vil vanligvis være større og mer individuelle, der hver tjeneste ofte har en pipeline for utrulling. Serverløs har flere og mindre komponenter som gjør at terraform er ofte brukt, et verktøy for å lagre infrastruktur som kode.  

 

Observability (overvåkning): Hvordan endres overvåkning, logging og feilsøking når man går fra mikrotjenester til en serverless arkitektur? Hvilke utfordringer er spesifikke for observability i en FaaS-arkitektur? 

Overvåking 

Endring i overvåking  

Forskjellen i å overvåke de forskjellige systemene er stort, serverless har en veldig kort oppetid på tjeneste, men mikrotjenster er designet for å kjøre lenge. Målinger i FAAS vil handle mer om hvor mange ganger en vis funksjon blir kallet og tid til noe ble gjort. I mirkotjenster handler det mer om selve resursene (cpu, minne og lagring) til serveren tjensten kjører på. Dette er et produkt av hoved forskjellen på arkitekturen, langtidskjørene prosess mot korttids (on demand) funksjoner. 

 

Logging 

Serverløs vil ha mer fragmentert logging fordi hver tjeneste har sin egen log, dette kan skape oversikt i systemet hvis det ikke er håndtert riktig. Tjenester som Cloudwatch kan hjelpe med å få bedre oversikt, men den må konfigureres riktig. Lagring av logger i skyen kan også bli dyrt.  

Feilsøking  

Det kan bli vanskeligere å filsøker fordi man ikke har tilgang til selve maskinene der programmet kjører, dette kan komplisere feilsøkingen. Serverløs kan inneholde lage funksjon kjeder så det kan være vanskelig å finne opphavet til en feil. 

 

 

 

Skalerbarhet og kostnadskontroll: Diskuter fordeler og ulemper med tanke på skalerbarhet, ressursutnyttelse, og kostnadsoptimalisering i en serverless kontra mikrotjenestebasert arkitektur. 

Kostnader 

Med en mikrojeneste-arkitektur vil kostnadene være mer forutsigbare enn med en serverløs modell, der man betaler basert på faktisk bruk. Dette har både positive og negative konsekvenser basert på hva applikasjonen trenger. Serverløs er spesielt fordelaktig dersom tjenesten ikke brukes kontinuerlig, siden man ungår å betale for en inaktiv server. Kostnadene i serverløs kan også bli uforutsigbare ved dårlig konfigurasjon eller under perioder med høy belastning. 

Skalering 

I en serverløs applikasjon kjører alle deler av systemet uavhengig av hverandre, som gjør at systemet kan skalere presist der flaskehalsen oppstår. Dette gjør skalering i skyen svært effektivt. Et problem er imidlertid at dersom en funksjon ikke har vært brukt på en stund, kan det ta litt tid før den blir aktivert (kaldstart), noe som kan påvirke responstiden. I en mikrotjeneste struktur kan man bare skalere hele moduler du kan altså ikke fokusere inn på selve delen som er tregest. Hvis en RabbitMQ-kø fylles opp, kan systemet dynamisk spinne opp en ny container som konsumerer fra køen. Denne prosessen kan ta litt tid, men den oppnår samme mål ved å håndtere økt belastning. Skalering er hoved argumentet for serverløs, skalering av mikrotjenster kan være veldig komplisert.  

Ressursutnyttelse 

Mikrotjenster har forhåndsdefinerte ressurser, noe som gjør at de ikke kan tilpasse seg dynamisk. Dette betyr at de enten vil ha for mye resurser eller for lite ressurser, noe som ikke er gunstig. Serverløs funksjoner, derimot, bruker bare resursene funksjonen trenger for å kjøre, dette fører til langt mer optimalisert ressursbruk.  

Eierskap og ansvar: Hvordan påvirkes DevOps-teamets eierskap og ansvar for applikasjonens ytelse, pålitelighet og kostnader ved overgang til en serverless tilnærming sammenlignet med en mikrotjeneste-tilnærming? 

Veldig mye av ansvaret går over på skyleverandøren,  

 

 