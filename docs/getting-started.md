# Getting Started

Deze handleiding biedt een overzicht van de stappen die nodig zijn om dit project lokaal te installeren, tests uit te voeren, scenario's te schrijven en te valideren, automatisering toe te passen/uit te breiden en hoe release versies gegenereerd kunnen worden.

## Vereisten
- Valideer met behulp van de in Gherkin gespecificeerde voorbeelden/scenarios en Cucumber geautomatiseerd de API contract implementatie. De automation is geïmplementeerd met behulp van Javascript en wordt in de CI/CD pipeline uitgevoerd mbv [Node.js v20](https://github.com/marketplace/actions/setup-node-js-environment)
- [SonarQube](https://docs.sonarsource.com/sonarqube/latest/) voor statische analyse van de provider implementatie ten behoeve van code kwaliteit
- [CodeQL](https://codeql.github.com/docs/) voor geautomatiseerd uitvoeren van security checks
- [GitHub Actions](https://docs.github.com/en/actions) voor het inrichten van een CI/CD pipeline voor geautomatiseerd builden, valideren en releasen van een API
- [Elastic Common Schema](https://www.elastic.co/guide/en/ecs-logging/overview/current/intro.html) voor het formatteren van applicatie logs zodat ten behoeve van uniforme verwerking door de ELK-stack
- PostgreSQL 11.21-alpine container image voor het hosten van de BRP personen registratie database

Om te kunnen werken met de Docker container images die gegenereerd kunnen worden aan de hand van dit project:
- Docker Desktop
- Docker CLI

Gegenereerde container images worden gepubliceerd in deze [GitHub Container Registry](https://github.com/features/packages).

## 1. Installeren van NPM packages

Om de vereiste dependencies te installeren, voer `npm install` uit in de hoofdmap van het project.

## 2. Starten van containers

Elke repository bevat een script om de bijbehorende containers op te kunnen starten. Bijvoorbeeld in [Personen Data Service](https://github.com/BRP-API/personen-data-service) zijn de volgende [scripts](https://github.com/BRP-API/personen-data-service/tree/main/scripts) beschikbaar:
1. scripts/containers-build.sh
2. scripts/containers-start.sh
3. scripts/containers-stop.sh

Voer een van deze scripts uit om de bijbehorende containers te builden, starten of stoppen.

## 3. Uitvoeren van Cucumber testen

Binnen dit project wordt gebruikgemaakt van [Cucumber](https://cucumber.io/docs/cucumber/) voor geautomatiseerde testen. Voer het volgende commando uit om een test uit te voeren.

`npx cucumber-js features/{map}/{feature}`

`npx cucumber-js features/{map}/{feature}:{regelnummer}`

## 4. Uitbreiden van pipeline

Bij het toevoegen van nieuwe testen is het van belang dat dit uitgevoerd wordt in de pipeline. Controleer `github/workflows/ci.yml` in de desbetreffende repository of de juiste stappen worden uitgevoerd of breid eventueel `scripts/specs-verify.sh` om nieuw toegevoegde scenario's uit te voeren.

## 5. Genereren release versie

Handmatig releasen van haal-centraal API's (oude situatie) https://github.com/BRP-API/haal-centraal

1. Voor een patch/minor/major versie release pas het versienummer aan in het `.csproj` bestand.

2. `publish.sh` bevat de link naar de container registry. Pas aan indien nodig en controleer welke naam je nodig hebt. Bijvoorbeeld gba-historie-api.

Tip: pas `publish.sh` aan zodat dit naar de Github container registry gaat.

3. Elk project beschikt over een Dockerfile. Dit dockerfile wordt uitgevoerd aan de hand van de parameter die meegegeven wordt aan `publish.sh`

Tip: verwijder of restore appsettings.development.json anders worden deze settings meegenomen in de release variant.

4. Release versie 2.0.5-010120250758

Voer het `publish.sh` script uit en geef de juiste parameters mee. Voorbeeld:

```sh

./publish.sh <major.minor.patch-buildnummer> <image-name>

./publish.sh 2.0.5-20250101090758 gba-api
```

Let op: zolang er gebruik wordt gemaakt van de Azure Container Registry, houdt rekening met het tijdsverschil (bijvoorbeeld UTC-2). Om 09:58 in UTC-2 te releasen gebruik een buildnummer eindigend op 0758.