## Cucumber profielen

De volgende Cucumber profielen zijn toegevoegd om het uitvoeren van de features voor de Personen Informatie Service, Personen Data Service en Gezag API te vereenvoudigen. De profielen zijn te vinden in het cucumber.js bestand

- InfoApi
- InfoApiDeprecated
- DataApi
- DataApiDeprecated
- GezagApi
- GezagApiDeprecated

De GezagApi profiel is als volgt gedefinieerd:

```
  GezagApi: {
    worldParameters: {
      apiUrl: 'http://localhost:8080/api/v1/opvragenBevoegdheidTotGezag',
      api: 'gezag-api',
      logger: {
        level: 'warn'
      },
      addAcceptGezagVersionHeader: true
    },
    tags: 'not @skip-verify and not @deprecated and ((not @data-api and not @info-api) or @gezag-api)'
  }
```

| parameter                   | omschrijving |
| --------------------------- | ------------ |
| apiUrl                      | endpoint van de API |
| api                         | context waarin de scenarios moet worden uitgevoerd. Deze wordt in de automation gebruikt bij het opbouwen van de verwachte Gezag response voor de info/data/gezag api|
| logger.level                | kan worden gezet op 'info' om te kunnen zien welke sql statements zijn uitgevoerd |
| addAcceptGezagVersionHeader | hiermee wordt aangegeven of de accept-gezag-version header moet worden meegestuurd met een request |
| tags                        | geeft aan welke scenarios moet worden uitgevoerd. Bij het aanroepen van Cucumber met de GezagApi profiel worden alle scenarios uitgevoerd die zijn getagd met @gezag-api of niet zijn getagd |

Het uitvoeren van documentatie features met de GezagApi profiel ziet er als volgt uit:

```
npx cucumber-js features/docs -p GezagApi
```