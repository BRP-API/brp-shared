  #language: nl

@integratie @stap-documentatie
Functionaliteit: Persoon stap definities

  Achtergrond:
    Gegeven de tabellen 'lo3_pl' bevat geen rijen

  Scenario: de persoon met burgerservicenummer '[bsn]'
    Gegeven de persoon 'Gerda' met burgerservicenummer '000000012'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Gerda' de volgende rij in tabel 'lo3_pl'
    | pl_id | geheim_ind |
    | 1     | 0          |
    En heeft de persoon 'Gerda' de volgende rij in tabel 'lo3_pl_persoon'
    | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr |
    | 1     | P            | 0         | 0       | 000000012         |

  Scenario: is minderjarig
    Gegeven de persoon 'Gerda' met burgerservicenummer '000000012'
    * is minderjarig
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Gerda' de volgende rij in tabel 'lo3_pl'
    | pl_id | geheim_ind |
    | 1     | 0          |
    En heeft de persoon 'Gerda' de volgende rij in tabel 'lo3_pl_persoon'
    | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geboorte_datum     |
    | 1     | P            | 0         | 0       | 000000012         | gisteren - 17 jaar |

  Scenario: is ingeschreven in de BRP
    Gegeven de persoon 'Gerda' met burgerservicenummer '000000012'
    * is ingeschreven in de BRP
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Gerda' de volgende rij in tabel 'lo3_pl'
    | pl_id | geheim_ind |
    | 1     | 0          |
    En heeft de persoon 'Gerda' de volgende rij in tabel 'lo3_pl_persoon'
    | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr |
    | 1     | P            | 0         | 0       | 000000012         |
    En heeft de persoon 'Gerda' de volgende rij in tabel 'lo3_pl_verblijfplaats'
    | pl_id | volg_nr | inschrijving_gemeente_code |
    | 1     | 0       | 0518                       |