# Getting Started: documenteren van de requirements voor de BRP APIs met behulp van Gherkin

## Wat is Gherkin?

Gherkin is een set van regels en sleutelwoorden zoals 'Gegeven', 'Als' en 'Dan' die kunnen worden gebruikt om structuur en betekenis te geven aan de specificaties van de functionaliteit van een systeem zodat de specificaties begrijpbaar zijn voor zowel technische als niet-technische stakeholders. Met behulp van tooling zoals Cucumber kunnen deze specificaties worden geautomatiseerd en worden gebruikt om te verifiëren dat het systeem is geïmplementeerd conform specificaties.

Belangrijk, Gherkin is geen test tool/framework. Het is geen vervanging voor andere testen zoals unit testen, integratie testen, performance testen, etc. Het is eerder een vervanging voor traditionele specificatie documenten. De primaire doel van een Gherkin feature bestand is begrijpbare, levende documentatie. Het levend houden van de documentatie wordt bereikt door de specificaties om te zetten naar uitvoerbare specificaties die valideren dat documentatie en implementatie niet uit elkaar lopen.

## Aanbevelingen voor het beschrijven van specificaties met Gherkin

### Vermijd implementatie details in Gherkin specificaties

Onderstaand voorbeeld is een stap met veel implementatie detail. M en V zijn voor iedereen bekende codes waarmee het geslacht van een persoon wordt aangeduid, maar O niet. Dat 20120920 een datum voorstelt in JJJMMDD formaat kan door iedereen worden afgeleid. Maar dat met 00000000 een volledig onbekende datum wordt bedoeld, is minder voor de hand liggend. En de 'in onderzoek' aanduidingen zijn zonder extra documentatie gewoon magic numbers.

```
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
    | geslachtsaanduiding (04.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | M                           | 010120                          | 20120920                       |
```
Voorbeeld 1a. Magic numbers in een stap

In onderstaand voorbeeld zijn de magic numbers vervangen door beschrijvende termen die duidelijk maken wat er met de waarden wordt bedoeld.

```
    Gegeven de persoon met burgerservicenummer '000000097' heeft de volgende gegevens
    | geslachtsaanduiding (04.10) | aanduiding in onderzoek (83.10)  | datum ingang onderzoek (83.20) |
    | man                         | burgerservicenummer in onderzoek | 2012-09-20                     |
```
Voorbeeld 1b. Voorbeeld 1a herschreven zonder magic numbers

Voor datums kunnen de volgende termen worden gebruikt om (deels) onbekende datum aan te duiden:
| term                    | aanduiding                                                             |
|-------------------------|------------------------------------------------------------------------|
| onbekend                | volledig onbekende datum (00000000)                                    |
| deze maand/vorige maand | datum in de huidige/vorige maand met onbekende dag (JJJJMM00)          |
| dit jaar/vorig jaar     | datum in het huidige/vorige jaar met onbekende maand en dag (JJJJ0000) |
| vandaag/gisteren/morgen | relatieve datum (JJJJMMDD)                                             |
| vandaag 12 jaar geleden | geeft bijv. aan dat een kind vandaag 12 jaar is geworden               |


### Vermijd technische details in Gherkin specificaties

In de volgende als stappen zijn alle verplichte parameters beschreven voor respectievelijk het zoeken op burgerservicenummer en het zoeken op geslachtsnaam en geboortedatum. 

```
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | naam.voornamen                  |

    Als personen wordt gezocht met de volgende parameters
    | naam             | waarde                              |
    | type             | ZoekMetGeslachtsnaamEnGeboortedatum |
    | geslachtsnaam    | Jansen                              |
    | geboortedatum    | 2000-01-01                          |
    | fields           | naam.voornamen                      |
```
Voorbeeld 2a. Technische details in als stappen

Het opnemen van alle verplichte velden in de als stap illustreert de Regel 'De burgerservicenummer is een verplichte parameter bij zoekmethode 'RaadpleegMetBurgerservicenummer'', maar niet om de regel 'Alleen met fields gevraagde velden worden geleverd' te illustreren. Betere als stappen om deze Regel te illustreren zijn:

```
    Als 'naam.voornamen' wordt gevraagd van personen gezocht met burgerservicenummer van 'Peter'

    Als 'naam.voornamen' wordt gevraagd van personen gezocht met geslachtsnaam en geboortedatum van 'Peter'
```
Voorbeeld 2b. Voorbeeld 2a herschreven zonder technische details

### Definieer een nieuwe stap als met bestaande stappen een regel niet goed kan worden geïllustreerd

Om de Regel 'De fields parameter bevat een lijst met maximaal 130 veld paden' te illustreren is een scenario gemaakt waarbij 131 veldpaden zijn opgegeven voor de fields parameter. Zie https://github.com/BRP-API/brp-shared-dotnet/blob/main/features/validatie/personen/fields-fout-cases.feature#L125

```
Regel: De fields parameter bevat een lijst met maximaal 130 veld paden

  @fout-case
  Scenario: De fields parameter bevat meer dan 130 veld paden bij het raadplegen van personen
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000139                       |
    | fields              | <fields>                        |

  Voorbeelden:
    | fields |
    | aNummer,adressering,adressering.adresregel1,adressering.adresregel2,adressering.adresregel3,adressering.land,adressering.aanhef,adressering.aanschrijfwijze,adressering.aanschrijfwijze.aanspreekvorm ... veldpad131 | 
```
Voorbeeld 3a. Scenario waarin de situatie (er zijn meer dan 130 veldpaden opgegeven) niet goed wordt geïllustreerd

Dit is niet goed leesbaar en het is moeilijk te valideren of er daadwerkelijk meer dan 130 veldpaden zijn opgegeven. Het is dan beter om een nieuwe stap te definiëren waarmee dit duidelijker kan worden geïllustreerd. Bijvoorbeeld:

```
  Als 131 velden wordt gevraagd van personen bij het zoeken met burgerservicenummer
```
Voorbeeld 3b. Voorbeeld 3a herschreven met stap die de situatie beter illustreert

Voor het illustreren van Bewoningen Regels is een soortgelijke stap gedefinieerd:

```
  Gegeven er zijn 101 personen ingeschreven op adres 'A1' met de volgende gegevens
  | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
  | 0800                              | 20200818                           |
```

### Geef voorkeur aan 'expressieve' stappen boven herbruikbare stappen

Een expressieve stap is een stap die de situatie of actie duidelijk beschrijft zonder dat er extra uitleg nodig is.
Een herbruikbare stap is een stap die generiek genoeg is om in meerdere situaties te worden gebruikt, maar daardoor minder duidelijk kan zijn.

Het volgende voorbeeld illustreert dit principe. De expressieve stap:
```
  Dan is het gezag over 'Jan' eenhoofdig ouderlijk gezag met ouder 'Martha'
```
Voorbeeld 4a. Expressieve stap

En de volgende generieke stap waarmee hetzelfde is uitgedrukt:
```
  Dan heeft de response een persoon met een gezag met de volgende gegevens
  | type                     | minderjarige.burgerservicenummer | ouder.burgerservicenummer |
  | EenhoofdigOuderlijkGezag | Jan                              | Martha                    |
```
Voorbeeld 4b. Generieke stap voor de expressieve stap van voorbeeld 4a

En die ook kan worden gebruikt om aan te geven dat een persoon een nationaliteit heeft
```
  Dan heeft de response een persoon met een nationaliteit met de volgende gegevens
  | type          | nationaliteit.code | nationaliteit.omschrijving |
  | Nationaliteit | 0001               | Nederlandse                |
```

De volgende gegeven stap:

```
  Gegeven de minderjarige persoon 'Bert' met twee ouders 'Gerda' en 'Aart' die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren
```

beschrijft duidelijker de situatie dan de volgende generieke stappen:

```
  Gegeven de minderjarige persoon 'Gerda'
  En de persoon 'Aart'
  En de persoon 'Bert'
  En 'Bert' heeft als ouders 'Gerda' en 'Aart'
```

Hergebruik kan beter worden toegepast in de code achter de stappen (stap definities) door functies te maken die de gemeenschappelijke logica bevatten. Een voorbeeld hiervan is te zien in de [implementatie van dit expressieve stap](https://github.com/BRP-API/brp-api-gezag/blob/main/features/step_definitions/persona/gegeven-stepdefs-persona.js#L47). 

### Beschrijf/benoem een requirement in een Regel en illustreer de Regel met scenarios/voorbeelden en niet meer dan dat

De Gherkin sleutelwoord **Rule/Regel** kan worden gebruikt om een requirement te benoemen. Een best practice is om een requirement zo kort en bondig mogelijk te benoemen (in één regel) en deze regel te illustreren met concrete voorbeelden. Het is belangrijk dat de voorbeelden alleen de Regel illustreren en niet meer dan dat.
Een indicatie dat er meer scenarios zijn toegevoegd dan nodig is om de Regel te illustreren, is wanneer scenarios erg op elkaar lijken. Onderstaand voorbeeld is een Regel met twee scenarios waar alleen de opgegeven datum verschilt.

```
Regel: Het vragen van één of meerdere velden van een 'datum' veld levert alle velden van de 'datum' veld

  Abstract Scenario: een 'VolledigeDatum' veld wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | geboortedatum (03.10) |
    | 19561115              |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000152                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
    | naam              | waarde           |
    | datum.type        | Datum            |
    | datum.datum       | 1956-11-15       |
    | datum.langFormaat | 15 november 1956 |

    Voorbeelden:
    | fields                                   |
    | geboorte.datum                           |
    | geboorte.datum.type                      |
    | geboorte.datum.datum                     |
    | geboorte.datum.langFormaat               |
    | geboorte.datum.jaar                      |
    | geboorte.datum.maand                     |
    | geboorte.datum.onbekend                  |
    | geboorte.datum.jaar,geboorte.datum.maand |

  Abstract Scenario: een 'JaarMaandDatum' veld wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000153' heeft de volgende gegevens
    | geboortedatum (03.10) |
    | 19780300              |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                          |
    | type                | RaadpleegMetBurgerservicenummer |
    | burgerservicenummer | 000000153                       |
    | fields              | <fields>                        |
    Dan heeft de response een persoon met de volgende 'geboorte' gegevens
    | naam              | waarde         |
    | datum.type        | JaarMaandDatum |
    | datum.jaar        | 1978           |
    | datum.maand       | 3              |
    | datum.langFormaat | maart 1978     |

    Voorbeelden:
    | fields                                   |
    | geboorte.datum                           |
    | geboorte.datum.type                      |
    | geboorte.datum.datum                     |
    | geboorte.datum.langFormaat               |
    | geboorte.datum.jaar                      |
    | geboorte.datum.maand                     |
    | geboorte.datum.onbekend                  |
    | geboorte.datum.jaar,geboorte.datum.maand |
```
Voorbeeld 5. Redundante scenarios voor een Regel

Een mogelijke reden dat deze extra scenarios (voor elke datum type eenzelfde scenario) zijn toegevoegd, is omdat deze Regel conflicteert met de Regel 'De fields parameter bevat veld paden die verwijzen naar een bestaand veld'. Afhankelijk van de datum type kan een gevraagd datum veld wel of niet bestaan bij het datum type. Door het toevoegen van deze extra scenarios wordt getest dat de correcte Regel is geïmplementeerd voor elke datum type.

### Gebruik Cucumber Expressions om stappen te koppelen aan automation

Een stap in een scenario is gekoppeld aan de functie van een stap definitie als de tekst van de stap match met de stap definitie expressie. Standaard worden reguliere expressies (Regular Expressions) gebruikt om te bepalen of er een match is. Zie onderstaand voorbeeld:
```
Given(/^de persoon met burgerservicenummer '(\d*)' heeft de volgende gegevens$/, function (burgerservicenummer, dataTable) {
    createPersoon(this.context, burgerservicenummer, dataTable);
});
Voorbeeld 6a. Stap definitie met reguliere expressie

```
De belangrijkste nadeel van het gebruik van reguliere expressies als stap definitie expressie is dat een stap aan meerdere stap definities kan worden gekoppeld als de reguliere expressie niet strict genoeg is. Dit leidt tot foutmeldingen tijdens het uitvoeren van de specificaties.

Een betere alternatief is het gebruik van Cucumber Expressions. [Cucumber Expressions](https://github.com/cucumber/cucumber-expressions?tab=readme-ov-file#readme) zijn expressies die speciaal zijn ontworpen voor het koppelen van stappen aan stap definities. Cucumber Expressions kent standaard parameter types die kunnen worden gebruikt om parameters in stappen te definiëren. Deze parameter types zijn makkelijker te lezen en te begrijpen dan reguliere expressies. Zie [Parameter Types](https://github.com/cucumber/cucumber-expressions?tab=readme-ov-file#parameter-types) in de Cucumber Expressions documentatie voor een overzicht van de standaard parameter types. Onderstaand voorbeeld toont dezelfde stap definitie als in Voorbeeld 6a, maar dan met Cucumber Expressions:
```
Given('de persoon met burgerservicenummer {int} heeft de volgende gegevens', function (burgerservicenummer, dataTable) {
    createPersoon(this.context, burgerservicenummer, dataTable);
});
Voorbeeld 6b. Stap definitie met Cucumber Expressions

In Cucumber Expressions kan ook worden uitgebreid met custom parameter types. Door het implementeren van custom parameter types kunnen termen zoals 'gisteren', 'vorige maand' of 'vandaag 12 jaar geleden' worden omgezet naar een datum. Zie [Custom Parameter Types](https://github.com/cucumber/cucumber-expressions?tab=readme-ov-file#custom-parameter-types). Stappen die alleen verschillen in de datum parameter kunnen dan worden gekoppeld aan dezelfde functie zoals in onderstaand voorbeeld:
```
Given('de {onbekende datum} geboren persoon {string} met twee ongehuwde ouders {string} en {string}', minderjarigePersoonMetOngehuwdeOuders);
Given('de {relatieve datum} geboren persoon {string} met twee ongehuwde ouders {string} en {string}', minderjarigePersoonMetOngehuwdeOuders);
```
Voorbeeld 6c. Stap definities met custom parameter types

Voorbeelden van scenarios en stap definities die gebruik maken van Cucumber Expressions en Custom Parameter Types zijn te vinden in brp-api-gezag GitHub repository:
- [Scenarios](https://github.com/BRP-API/brp-api-gezag/blob/main/features/specs/gerechtelijke-uitspraak.feature)
- [Stap definities](https://github.com/BRP-API/brp-api-gezag/blob/main/features/step_definitions/persona/gegeven-stepdefs-persona.js)
- [Custom Parameter Types](https://github.com/BRP-API/brp-api-gezag/blob/main/features/step_definitions/parameter-types.js)
