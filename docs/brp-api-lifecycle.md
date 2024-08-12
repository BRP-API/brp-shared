# BRP API lifecycle

``` mermaid
flowchart TD

    subgraph Definieer
        Define
    end
    subgraph Ontwerp
        direction LR
        DescribeAPI --> DesignAPI
        DesignAPI --> DescribeAPI --> DocumentAPI --> PublishAPI
        DocumentAPI --> DescribeAPI
    end
    subgraph Implementeer
        direction LR
        Test --> Develop
        Develop --> Test --> DeliverAPI
    end
    subgraph Beheer
      direction LR
      DeployACC --> DeployLAP --> DeployPRD
    end

    Definieer --> Ontwerp
    Ontwerp --> Implementeer
    Implementeer --> Beheer
    
    
    Define["Definieer klant
    vraag/behoefte"]

    DesignAPI["Ontwerp
    API contract"]

    DescribeAPI["Beschrijf
    API contract"]

    DocumentAPI["Documenteer
    API contract"]

    PublishAPI["Publiceer
    API contract"]

    Develop["Implementeer
    API contract"]

    Test["Valideer/Test
    API contract
    Implementatie"]

    DeliverAPI["Release
    API contract
    Implementatie"]

    DeployACC["Installeer 
    release op ACC"]

    DeployLAP["Installeer
    release op LAP"]

    DeployPRD["Installeer
    release op PRD"]
```

## Ontwerp API contract

- Welk API style? REST/HTTP, GraphQL, gRPC, events
- Security Requirements
  - mTLS
  - [OAuth 2.0](https://oauth.net/2/)
- [Threat modeling](https://owasp.org/www-community/Threat_Modeling_Process)
  - [OWASP API Security Top 10](https://owasp.org/API-Security/)
  - [OWASP Developer Guide](https://owasp.org/www-project-developer-guide/draft/)

## Modelleer API contract

- [OpenAPI Specification](https://spec.openapis.org/oas/v3.1.0) voor het modelleren van een API contract conform de REST/HTTP API style
- [Redocly CLI (OAS bundler)](https://redocly.com/redocly-cli)
- [Spectral (OAS linter)](https://stoplight.io/open-source/spectral)
- [Redoc (OAS viewer)](https://redocly.github.io/redoc/)

## Documenteer API contract

Documenteer met voorbeelden/scenarios
- hoe de klant vraag/behoefte met de API contract wordt gerealiseerd
- de toe te passen [Proactive Controls](https://owasp.org/www-project-developer-guide/draft/implementation/documentation/proactive_controls/)
  - [input validatie](https://owasp.org/www-project-developer-guide/draft/design/web_app_checklist/validate_inputs/)
  - [access controls (autorisatie)](https://owasp.org/www-project-developer-guide/draft/design/web_app_checklist/access_controls/)

Gebruik:
- [Gherkin](https://cucumber.io/docs/gherkin/) voor het beschrijven van de voorbeelden/scenarios
- [Cucumber](https://cucumber.io/docs/cucumber/) voor het automatiseren van de voorbeelden/scenarios

## Publiceer API contract

- [GitHub Pages](https://pages.github.com/)

## Implementeer & Valideer API contract

### .NET
- [.NET 6.0](https://dotnet.microsoft.com/en-us/download/dotnet)
- [NSwag](https://github.com/RicoSuter/NSwag) voor het genereren van consumer/provider .NET code uit een in OAS gespecificeerde API contract
- [ECS (Elastic Common Schema)](https://www.elastic.co/guide/en/ecs-logging/dotnet/current/intro.html) voor het formatteren van logs conform de [Elastic Common Schema](https://www.elastic.co/guide/en/ecs-logging/overview/current/intro.html)

### JAVA

TODO

### Algemeen
- Valideer met behulp van de in Gherkin gespecificeerde voorbeelden/scenarios en Cucumber geautomatiseerd de API contract implementatie. De automation is geïmplementeerd met behulp van Javascript en wordt in de CI/CD pipeline uitgevoerd mbv [Node.js v20](https://github.com/marketplace/actions/setup-node-js-environment)
- [SonarQube](https://docs.sonarsource.com/sonarqube/latest/) voor statische analyse van de provider implementatie ten behoeve van code kwaliteit
- [CodeQL](https://codeql.github.com/docs/) voor geautomatiseerd uitvoeren van security checks
- [GitHub Actions](https://docs.github.com/en/actions) voor het inrichten van een CI/CD pipeline voor geautomatiseerd builden, valideren en releasen van een API
- [OpenAPI Generator](https://github.com/OpenAPITools/openapi-generator) voor het genereren van consumer/provider code uit een in OAS gespecificeerde API contract
- [Elastic Common Schema](https://www.elastic.co/guide/en/ecs-logging/overview/current/intro.html) voor het formatteren van applicatie logs zodat ten behoeve van uniforme verwerking door de ELK-stack

## Release API contract implementatie

De BRP API wordt gepackaged als Docker Container images

- Docker Desktop
- Docker Compose
- [GitHub Container Registry](https://github.com/features/packages)

## Beheer API releases

- Kubernetes/Rancher
- ELK-stack