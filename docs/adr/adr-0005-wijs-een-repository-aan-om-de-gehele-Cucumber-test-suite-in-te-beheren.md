# ADR 0005: Wijs een repository aan om de gehele Cucumber test suite in te beheren

## Status
Voorstel

## Context
De Cucumber test suite wordt op meerdere repositories beheerd. Dit leidt ertoe dat aanpassingen in verschillende repositories over en weer moeten worden gesynchroniseerd. Deze tweerichtingsverkeer synchronisatie leidt tot allerlei problemen.

Synchronisatie is een gedeeltelijk handmatige actie waarbij het synchroniseren niet gebeurt met behulp van Git, maar door bestanden simpelweg te overschrijven. Hierdoor kan het voorkomen dat aanpassingen verloren gaan, bijvoorbeeld wanneer meerdere ontwikkelaars hetzelfde bestand hebben bewerkt of door aanpassingen in de verkeerde volgorde te synchroniseren. Dit is vooral een probleem wanneer aanpassingen lang blijven staan, doordat pull requests lang open blijven. Een ontwikkelaar moet vervolgens de verschillende pull requests, mogelijk verspreid over meerdere repositories, in de juiste volgorde mergen met het risico dat aanpassingen verloren gaan en de pipeline breekt.

## Beslissing
De repository Haal Centraal Bevragen wordt aangewezen als de plek waar de algehele Cucumber test suite wordt beheerd. Hierin wordt een mono-repository structuur gemaakt. Dit houdt in dat iedere microservice repository zijn eigen folder krijgt. De gedeelde code, zoals de step defininitions, krijgt ook een eigen folder. Vanuit deze repository worden vervolgens de juiste folders naar de verschillende microservice repositories gesynchroniseerd. **Belangrijk: de synchronisatie is eenrichtingsverkeer**. Dit lost de bovenstaande synchronisatie problemen op.

## Consequenties
### Voordelen
- Aanpassingen kunnen niet meer door synchronisatie verloren gaan.
- Aanpassingen hoeven niet meer in een stricte volgorde gemerged te worden.

### Nadelen
- Pipeline wordt complexer, omdat het voortaan per microservice repository de juiste folders moet selecteren voor synchronisatie.

## Datum
2025-03-27
