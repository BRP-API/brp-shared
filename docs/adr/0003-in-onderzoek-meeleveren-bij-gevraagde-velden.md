# ADR 0003: meeleveren van in onderzoek gegevens bij gevraagde velden

# Status
Voorstel

## Context

Wanneer de BRP API één of meer velden met authentieke gegevens uit de basisregistratie levert en één of meer van deze gegevens staan in onderzoek, dan moeten de bijbehorende in onderzoek gegevens worden meegeleverd. Een gegeven wordt in onderzoek gezet als bijvoorbeeld een terugmelding is gedaan door een afnemer die vermoedt dat het gegeven in de basisregistratie niet juist is. Als een gegeven in onderzoek staat, mag een afnemer besluiten het gegeven niet te gebruiken.

In de basisregistratie worden 6-cijferig codes gebruikt om aan te duiden welke gegevens in onderzoek staan. Bij de aanduiding wordt de ingangsdatum van het onderzoek geregistreerd en indien het onderzoek is beëindigd, wordt de datum einde onderzoek geregistreerd.

Naast de authentieke gegevens levert de BRP API ook informatie gegevens. Dit zijn gegevens die worden afgeleid aan de hand van één of meer authentieke gegevens. Wanneer één of meer onderliggende authentieke gegevens in onderzoek staan en het daarvan afgeleide informatieveld wordt geleverd, dan moet de afweging worden gemaakt of ook het afgeleide gegeven in onderzoek is.

Het altijd meeleveren van alle bijbehorende in onderzoek gegevens as-is voor een gevraagd authentiek veld of informatieveld levert geen bijdrage aan beter begrip van de afnemer over hetgeen is geleverd. De aanduidingen moeten correct worden geïnterpreteerd en vervolgens moet worden bepaald of het in onderzoek zijn van een geleverde gegeven relevant is binnen de context van de API-functie. Het onderzoek kan bijvoorbeeld al beëindigd zijn en dat de naam of geboortedatum van een bewoner in onderzoek staat doet niets af aan het feit dat de persoon een bewoner is op het gevraagde adresseerbaar object in de gevraagde periode.

## Beslissingen

Om de relevantie en bruikbaarheid van de in onderzoek gegevens te verhogen, hebben we de volgende beslissingen genomen:
- het authentieke gegeven `aanduiding gegeven in onderzoek` wordt vertaald naar een InOnderzoek object met boolean velden. De naam van zo'n boolean veld komt overeen met de naam van het bijbehorend veld. Een boolean veld wordt alleen op true gezet en geleverd als het bijbehorend veld in onderzoek staat én het bijbehorend veld wordt gevraagd. Het bijbehorend `datum ingang onderzoek` gegeven wordt meegeleverd in het bijbehorend datumIngangOnderzoek veld. Zie voorbeelden [gevraagd veld is een authentiek gegeven dat in onderzoek kan staan](#gevraagd-veld-is-een-authentiek-gegeven-dat-in-onderzoek-kan-staan)
- een informatieveld heeft, net als een veld voor een authentiek gegeven, één bijbehorend gelijknamig boolean veld. Dit boolean veld wordt alleen geleverd als het afgeleide informatieveld wordt gevraagd én als het boolean veld op true wordt gezet omdat één of meer onderliggende gegevens in onderzoek staan en het in onderzoek staan van de onderliggende gegevens is de reden voor twijfel aan de juistheid van het afgeleide informatieveld. Voor een informatieveld is er geen bijbehorend datumIngangOnderzoek veld omdat de onderliggende authentieke gegevens uit verschillende categoriën kan komen. Zie voorbeelden [gevraagd veld is afgeleid uit één authentiek gegeven dat in onderzoek kan staan](#gevraagd-veld-is-afgeleid-uit-één-authentiek-gegeven-dat-in-onderzoek-kan-staan) en [gevraagd veld is afgeleid uit meer authentieke gegevens van verschillende categoriën en deze gegevens kunnen in onderzoek staan](#gevraagd-veld-is-afgeleid-uit-meer-authentieke-gegevens-van-verschillende-categoriën-en-deze-gegevens-kunnen-in-onderzoek-staan)
- wanneer een informatieveld een object is, dan heeft het object een inOnderzoek boolean veld in plaats van een inOnderzoek object veld. Dit inOnderzoek veld wordt gevuld met true als één of meer onderliggende gegevens in onderzoek staan én het in onderzoek staan van de onderliggende gegevens is de reden voor twijfel aan de juistheid van het afgeleide informatieveld. Zie voorbeeld [gevraagd veld is een object die is afgeleid uit authentieke gegevens die in onderzoek kunnen staan en het in onderzoek staan van deze gegevens is relevant bij het gebruik van het object](#gevraagd-veld-is-een-object-die-is-afgeleid-uit-authentieke-gegevens-die-in-onderzoek-kunnen-staan-en-het-in-onderzoek-staan-van-deze-gegevens-is-relevant-bij-het-gebruik-van-het-object)
- in onderzoek gegevens worden niet geleverd als het onderzoek is beëindigd (datum einde onderzoek is gevuld).

## JSON voorbeelden voor een gevraagd veld met bijbehorend inOnderzoek veld  

### gevraagd veld is een authentiek gegeven dat in onderzoek kan staan

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

### gevraagd veld is afgeleid uit één authentiek gegeven dat in onderzoek kan staan

leeftijd wordt gevraagd en de hele categorie persoon staat in onderzoek (aanduiding: 010000)

```
{
    "leeftijd": ...,
    "inOnderzoek: {
        "leeftijd": true
    }
}
```

### gevraagd veld is afgeleid uit meer authentieke gegevens van verschillende categoriën en deze gegevens kunnen in onderzoek staan

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

### gevraagd veld is een object die is afgeleid uit authentieke gegevens die in onderzoek kunnen staan en het in onderzoek staan van deze gegevens is relevant bij het gebruik van het object

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

### gevraagd veld is een object die is afgeleid uit authentieke gegevens die in onderzoek kunnen staan maar het in onderzoek staan van deze gegevens is niet relevant bij het gebruik van het object

bewoning wordt gevraagd en de burgerservicenummer van een bewoner staat in onderzoek

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
