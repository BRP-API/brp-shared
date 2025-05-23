# BRP-API Versioning & Branching Strategie

v.b. personen data service

| omgeving | container image versie | git branch                            | opmerkingen |
| -------- | ---------------------- | ------------------------------------- | ----------- |
| PROD     | 2.0.0-202409010910     | main                                  | 1           |
| LAP      | 2.0.0-202409010910     | main                                  | 2           |
| ACC      | 2.3.1-202409240843     | chore/#6-multi-personen-gezag-aanroep | 3           |
| CI       | 2.3.1-202409300900     | chore/#6-multi-personen-gezag-aanroep | 4           |
| CI       | 2.4.0-202409301130     | feat/#7-full-text-search              | 5           |
| CI       | 2.0.1-202409301330     | fix/#8-filter-op-geboortedatum        |             |

1. Het is niet duidelijk welke container image versie op PROD draait en met welke git commit de PROD versie opnieuw kan worden gebouwd
2. Op LAP draait dezelfde container image versie als op PROD omdat afnemers op LAP hun aansluiting testen
3. Op ACC draait de container image versie die, als het goed wordt bevonden wordt gedeployed naar LAP
4. Elke commit met code wijzigingen leidt tot een nieuwe container image versie
5. Parallel aan de huidig geplande release wordt er gewerkt aan nieuwe functionaliteit

## Uitdagingen
- hotfix maken van de versie die op LAP/PROD draait
- quick fix maken van de versie die op ACC draait (willen we dit?)

## Proces aanpassingen
- Een container image is gereleased op PROD
  - Maak een release aan in de 'main' branch
    - release tag [major].[minor].[patch]
    - tag de container image die op dat moment op PROD draait met [major].[minor].[patch]-STABLE
- Er moet een hotfix worden gemaakt
  - maak een branch van de 'main' branch voor de fix van de issue in PROD
  - verhoog de patch versie in de hotfix branch
