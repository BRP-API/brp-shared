# ADR 0004: Niet hernoemen van de 'TweehoofdigOuderlijkGezag' type van de Gezagsrelatie type

## Status
Voorstel

## Context
De term 'TweehoofdigOuderlijkGezag' is geen bestaand term binnen het 'Gezag' domein. De correcte term hiervoor is 'GezamenlijkOuderlijkGezag'. Om het onboarden van afnemers van de BRP Personen API met betrekking tot het opvragen van de gezagsrelaties van een persoon te vergemakkelijken is gekeken of het mogelijk is om de term 'TweehoofdigOuderlijkGezag' te vervangen door 'GezamenlijkOuderlijkGezag'. De conclusie is dat dit niet mogelijk is zonder een breaking change.

## Beslissing
We hebben besloten om het vervangen van de term 'TweehoofdigOuderlijkGezag' door 'GezamenlijkOuderlijkGezag' uit te stellen totdat er een breaking change met meer business waarde moet worden geïntroduceerd. Verder hebben we besloten om deze wijziging wel in de documentatie door te voeren.

## Consequenties
### Voordelen
- Bestaande afnemers hoeven hun client code niet aan te passen

### Nadelen
- In de documentatie moet worden uitgelegd dat de termen 'TweehoofdigOuderlijkGezag' en 'GezamenlijkOuderlijkGezag' hetzelfde zijn
- In de automation code moet mapping worden geïmplementeerd zodat het gebruik van de term 'GezamenlijkOuderlijkGezag' in de gezag scenarios niet leidt tot het falen van deze scenarios

## Datum
2025-01-22
