  #language: nl

@integratie @stap-documentatie
Functionaliteit: Persoon stap definities

  Achtergrond:
    Gegeven de tabellen 'lo3_pl' bevat geen rijen

  Scenario: minderjarige is geadopteerd door één meerderjarige
    Gegeven de persoon 'Gerda' met burgerservicenummer '000000012'
    * is meerderjarig
    En de persoon 'Bert' met burgerservicenummer '000000036'
    * is minderjarig
    En 'Bert' is geadopteerd door 'Gerda' als ouder 1 op datum 'vandaag'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Gerda' de volgende rij in tabel 'lo3_pl'
    | pl_id | geheim_ind |
    | 1     | 0          |
    En heeft de persoon 'Gerda' de volgende rijen in tabel 'lo3_pl_persoon'
    | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geboorte_datum     |
    | 1     | P            | 0         | 0       | 000000012         | gisteren - 45 jaar |
    | 1     | K            | 0         | 0       | 000000036         | gisteren - 17 jaar |
    En heeft de persoon 'Bert' de volgende rij in tabel 'lo3_pl'
    | pl_id | geheim_ind |
    | 2     | 0          |
    En heeft de persoon 'Bert' de volgende rijen in tabel 'lo3_pl_persoon'
    | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geboorte_datum     | akte_nr | familie_betrek_start_datum |
    | 2     | P            | 0         | 1       | 000000036         | gisteren - 17 jaar |         |                            |
    | 2     | P            | 0         | 0       | 000000036         | gisteren - 17 jaar | 1AQ0100 |                            |
    | 2     | 1            | 0         | 0       | 000000012         | gisteren - 20 jaar |         | vandaag                    |
