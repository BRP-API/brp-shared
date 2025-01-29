# ADR 0003: meeleveren van in onderzoek gegevens bij gevraagde velden

# Status
Voorstel

## Context

Wanneer de BRP API één of meer velden met authentieke gegevens uit de basisregistratie levert en één of meer van deze gegevens staan in onderzoek, dan moet de bijbehorende in onderzoek gegevens worden meegeleverd. Een gegeven wordt in onderzoek gezet als bijvoorbeeld een terugmelding is gedaan door een afnemer die vermoedt dat het gegeven in de basisregistratie niet juist is. Als een gegeven in onderzoek staat, mag een afnemer besluiten het gegeven niet te gebruiken.

In de basisregistratie worden 6-cijferig codes gebruikt om aan te duiden welke gegevens in onderzoek staan. Bij de aanduiding wordt de ingangsdatum van het onderzoek geregistreerd en indien het onderzoek is beëindigd, wordt datum einde onderzoek geregistreerd.

Naast de authentieke gegevens levert de BRP API ook informatie gegevens. Dit zijn gegevens die worden afgeleid aan de hand van één of meer authentieke gegevens. Wanneer één of meer afgeleide gegevens in onderzoek staan en de bijbehorende informatie veld wordt geleverd, dan moet de in onderzoek van de afgeleide gegevens worden meegeleverd.

Het altijd meeleveren van de bijbehorende in onderzoek gegevens as-is voor een gevraagd en/of afgeleid veld levert geen bijdrage aan beter begrip van de afnemer over hetgeen geleverd. De aanduidingen moet correct worden geïnterpreteerd en vervolgens moet worden bepaald of het in onderzoek zijn van een geleverde gegeven relevant is binnen de context van de API-functie. Het onderzoek kan bijvoorbeeld al beëindigd zijn en dat de naam of geboortedatum van een bewoner in onderzoek staat doet niets af aan het feit dat de persoon een bewoner is op het gevraagde adresseerbaar object in de gevraagde periode.

## Beslissingen

Om de relevantie en bruikbaarheid van de in onderzoek gegevens te verhogen, hebben we de volgende beslissingen genomen:
- het `aanduiding gegeven in onderzoek` gegeven wordt vertaald naar een InOnderzoek object met boolean velden. De naam van zo'n boolean veld komt overeen met de naam van het bijbehorend veld. Een boolean veld wordt alleen op true gezet en geleverd als het bijbehorend veld in onderzoek staat en het bijbehorend veld wordt gevraagd. Het bijbehorend `datum ingang onderzoek` gegeven wordt meegeleverd in het bijbehorend datumIngangOnderzoek veld. Zie voorbeelden [gevraagd veld is een gegeven dat in onderzoek kan staan](#gevraagd-veld-is-een-gegeven-dat-in-onderzoek-kan-staan)
- een informatie veld heeft, net als een niet-informatie veld, één bijbehorend gelijknamig boolean veld. Dit boolean veld wordt op true gezet en geleverd als één of meer afgeleide gegevens in onderzoek staan en het informatie veld wordt gevraagd. Zie voorbeeld [gevraagd veld is afgeleid uit één gegeven dat in onderzoek kan staan](#gevraagd-veld-is-afgeleid-uit-één-gegeven-dat-in-onderzoek-kan-staan).
- wanneer de afgeleide gegevens van een informatie veld uit verschillende categoriën komt, dan heeft het bijbehorend InOnderzoek object geen datumIngangOnderzoek veld. Zie voorbeeld [gevraagd veld is afgeleid uit meer gegevens van verschillende categoriën en deze gegevens kunnen in onderzoek staan](#gevraagd-veld-is-afgeleid-uit-meerdere-gegevens-van-verschillende-categoriën-en-deze-gegevens-kunnen-in-onderzoek-staan)
- wanneer een informatie veld een object is, dan heeft het object een inOnderzoek boolean veld in plaats van een inOnderzoek object veld. Dit onderzoek veld wordt gevuld en geleverd als één of meer afgeleide gegevens in onderzoek staan. Zie voorbeeld [gevraagd veld is een object die is afgeleid uit gegevens die in onderzoek kunnen staan en het in onderzoek staan van deze gegevens is relevant bij het gebruik van het object](#gevraagd-veld-is-een-object-die-is-afgeleid-uit-gegevens-die-in-onderzoek-kunnen-staan-en-het-in-onderzoek-staan-van-deze-gegevens-is-relevant-bij-het-gebruik-van-het-object)
- in onderzoek gegevens worden niet geleverd als het onderzoek is beëindigd (datum einde onderzoek is gevuld).

## JSON voorbeelden voor een gevraagd veld met bijbehorend inOnderzoek veld  

### gevraagd veld is een gegeven dat in onderzoek kan staan

geboorte.datum veld wordt gevraagd en de hele groep geboorte staat in onderzoek (aanduiding: 010300)

```
{
    "geboorte": {
        "datum": ...,
        "inOnderzoek": {
            "datum": true,
            "datumIngangOnderzoek": { ... }
        }
    }
}
```

geboorte.datum veld wordt gevraagd en de geboorteplaats staat in onderzoek (aanduiding: 030320)

```
{
    "geboorte": {
        "datum": ...
    }
}
```

### gevraagd veld is afgeleid uit één gegeven dat in onderzoek kan staan

leeftijd wordt gevraagd en de hele categorie persoon staat in onderzoek (aanduiding: 010000)

```
{
    "leeftijd": ...,
    "inOnderzoek: {
        "leeftijd": true,
        "datumIngangOnderzoek": { ... }
    }
}
```

### gevraagd veld is afgeleid uit meerdere gegevens van verschillende categoriën en deze gegevens kunnen in onderzoek staan

adressering.aanschrijfwijze wordt gevraagd en hele groep naam (010200) en hele groep naam partner (050200) staan in onderzoek:

```
{
    "adressering": {
        "aanschrijfwijze": ...,
        "inOnderzoek": {
            "aanschrijfwijze": true
        }
    }
}
```

### gevraagd veld is een object die is afgeleid uit gegevens die in onderzoek kunnen staan en het in onderzoek staan van deze gegevens is relevant bij het gebruik van het object

gezag wordt gevraagd en hele groep familierechtelijke betrekking (026200) van ouder1 staat in onderzoek

```
{
    "gezag": [
        {
            "type": "GezamenlijkGezag",
            "minderjarige": {
                ...
            },
            "ouder": {
                ...
            },
            "derde": {
                ...
            },
            "inOnderzoek": true
        }
    ]
}
```

bewoning wordt gevraagd en datum aanvang adreshouding van de verblijfplaats van een bewoner staat in onderzoek

```
{
    "bewoningen": [
        {
            "adresseerbaarObjectIdentificatie": ...,
            "periode": { ... },
            "bewoners: [
                {
                    "burgerservicenummer": ...,
                    "inOnderzoek": true
                }
            ],
            "mogelijkeBewoners": []
        }
    ]
}
```

### gevraagd veld is een object die is afgeleid uit gegevens die in onderzoek kunnen staan maar het in onderzoek staan van deze gegevens is niet relevant bij het gebruik van het object

bewoning wordt gevraagd en de straatnaam van de verblijfplaats van een bewoner staat in onderzoek

```
{
    "bewoningen": [
        {
            "adresseerbaarObjectIdentificatie": ...,
            "periode": { ... },
            "bewoners: [
                {
                    "burgerservicenummer": ...
                }
            ],
            "mogelijkeBewoners": []
        }
    ]
}
```
