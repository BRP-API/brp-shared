
# Titel ADR
Opnemen van "in onderzoek" status in de BRP API

## Status
Besloten

## Context
De status "in onderzoek" moet uitsluitend worden opgenomen in de BRP API wanneer deze relevant is voor het gebruik van de API-functie. Daarmee wordt afgeweken van de regel dat in onderzoek gegevens altijd moeten worden geleverd als de BRP API een BRP gegeven of BRP afgeleid gegeven levert dat in de registratie in onderzoek staat. 
De BRP API levert geen "in onderzoek" gegevens over geleverde gegevens die niet tot de kern van de functionaliteit behoren, en geen bijdrage leveren aan beter begrip van de afnemer over hetgeen geleverd is.  

Wat betekent "in onderzoek"?
Een authentiek gegeven in een basisregistratie kan "in onderzoek" zijn, bijvoorbeeld omdat een terugmelding is gedaan door een afnemer die vermoedt dat het gegeven in de basisregistratie niet juist is. Als een gegeven in onderzoek staat, mag een afnemer besluiten het gegeven niet te gebruiken.  

## Beslissing
- **Opnemen van "in onderzoek" status**: De BRP API zal de status "in onderzoek" opnemen wanneer dit relevant is voor het gebruik van de API. De Bewoning API wordt gebruikt om bewoner-samenstellingen op een verblijfplaats te achterhalen. 
Dit betekent dat:
  - Een bewoner "in onderzoek" is als de verblijfplaats van de bewoner "in onderzoek" staat.
  - Een bewoner niet "in onderzoek" is als de naam of geboortedatum van de bewoner in onderzoek staat. Dat deze gegevens in onderzoek staan doet niets af aan het feit dat deze persoon een bewoner is op dit adres in deze periode en onderdeel uitmaakt van de geleverd bewonersamenstelling.

## Gevolgen
- **Positief**:
  - Verhoogde relevantie en bruikbaarheid van de API door alleen relevante onderzoeksstatussen op te nemen.
  - Duidelijkheid voor gebruikers van de API over wanneer een bewoner als "in onderzoek" wordt beschouwd.
- **Negatief**:
  - Mogelijke verwarring als gebruikers niet goed geïnformeerd zijn over de criteria voor "in onderzoek" status.
  - Extra documentatie en communicatie nodig om de beslisregels duidelijk te maken.

## Alternatieven Overwogen
- **Alternatief 1**: Alle onderzoeksstatussen van geleverde gegevens of onderliggende gegevens die in de afleiding zijn gebruikt worden opgenomen in de BRP API. In de BRP API Bewoning dus ook alle onderzoeken op naamgegevens en geboortedatum.
  - **Voordelen**: Vollediger beeld van alle onderzoeksstatussen.
  - **Nadelen**: Verhoogde complexiteit en mogelijk minder relevantie voor de primaire functies van de API, met als mogelijk gevolg dat het onderzoek dat wel relevant is wordt genegeerd.

## Besluitvormers
- PO BRP API. afgestemd met DO LG. Besluit kan worden genomen. Juridische grondslag in het kader van het [experiment dataminimalisatie].


## Datum
28 november 2024

[experiment dataminimalisatie]: https://www.rvig.nl/experimentbesluit-dataminimalisatie-brp-treedt-werking