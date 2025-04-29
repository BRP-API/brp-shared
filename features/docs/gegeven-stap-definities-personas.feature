# language: nl
@stap-documentatie @integratie
Functionaliteit: persona stap definities

  Scenario: de minderjarige persoon {kind} met twee ouders {moeder} en {vader} die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren
    Gegeven de minderjarige persoon 'Jan' met twee ouders 'Petra' en 'Piet' die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Jan   |          0 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum | geboorte_land_code | akte_nr |
      | Jan   |         0 |       0 | P            |         000000103 | Jan            |       20090428 |               6030 | 1XA3600 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | familie_betrek_start_datum | burger_service_nr | geslachts_naam | geboorte_datum | geslachts_aand | akte_nr |
      | Jan   |         0 |       0 |            1 |                   20090428 |         000000101 | Petra          |       19880430 | V              | 1XA3600 |
      | Jan   |         0 |       0 |            2 |                   20090428 |         000000102 | Piet           |       19880430 | M              | 1XB3624 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code |
      | Jan   |       0 |                       0518 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Petra |          0 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum | geslachts_aand | akte_nr |
      | Petra |         0 |       0 | P            |         000000101 | Petra          |       19880430 | V              | 1XA1200 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum | geboorte_land_code | akte_nr |
      | Petra |         0 |       0 | K            |         000000103 | Jan            |       20090428 |               6030 | 1XA3600 |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Piet  |          0 |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum | geslachts_aand | akte_nr |
      | Piet  |         0 |       0 | P            |         000000102 | Piet           |       19880430 | M              | 1XA2400 |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum | geboorte_land_code | akte_nr |
      | Piet  |         0 |       0 | K            |         000000103 | Jan            |       20090428 |               6030 | 1XB3624 |

  Scenario: de minderjarige persoon {kind} met twee gehuwde ouders {moeder} en {vader}
    Gegeven de minderjarige persoon 'Jan' met twee gehuwde ouders 'Petra' en 'Piet'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Jan   |          0 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum | geboorte_land_code | akte_nr |
      | Jan   |         0 |       0 | P            |         000000103 | Jan            |       20090428 |               6030 | 1XA3600 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | familie_betrek_start_datum | akte_nr | burger_service_nr | geslachts_naam | geboorte_datum | geslachts_aand |
      | Jan   |         0 |       0 |            1 |                   20090428 | 1XA3600 |         000000101 | Petra          |       19880430 | V              |
      | Jan   |         0 |       0 |            2 |                   20090428 | 1XA3600 |         000000102 | Piet           |       19880430 | M              |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code |
      | Jan   |       0 |                       0518 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Petra |          0 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum | geslachts_aand | akte_nr |
      | Petra |         0 |       0 | P            |         000000101 | Petra          |       19880430 | V              | 1XA1200 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum | geboorte_land_code | akte_nr |
      | Petra |         0 |       0 | K            |         000000103 | Jan            |       20090428 |               6030 | 1XA3600 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum | geslachts_aand | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort | akte_nr |
      | Petra |         0 |       0 | R            |         000000102 | Piet           |       19880430 | M              |            20050428 |                 0518 |                    6030 | H                 | 3XA1224 |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Piet  |          0 |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum | geslachts_aand | akte_nr |
      | Piet  |         0 |       0 | P            |         000000102 | Piet           |       19880430 | M              | 1XA2400 |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum | geboorte_land_code | akte_nr |
      | Piet  |         0 |       0 | K            |         000000103 | Jan            |       20090428 |               6030 | 1XA3600 |
    En heeft persoon 'Piet' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum | geslachts_aand | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort | akte_nr |
      | Piet  |         0 |       0 | R            |         000000101 | Petra          |       19880430 | V              |            20050428 |                 0518 |                    6030 | H                 | 3XA1224 |

  Scenario: de minderjarige persoon {kind} met één ouder {ouder}
    Gegeven de minderjarige persoon 'Jan' met één ouder 'Petra'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Petra |          0 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum | geslachts_aand | akte_nr |
      | Petra |         0 |       0 | P            |         000000101 | Petra          |       19880430 | V              | 1XA1200 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum | geboorte_land_code | akte_nr |
      | Petra |         0 |       0 | K            |         000000103 | Jan            |       20090428 |               6030 | 1XA3600 |
    Dan heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      | Jan   |          0 |
    En heeft persoon 'Petra' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | geboorte_datum | geboorte_land_code | akte_nr |
      | Jan   |         0 |       0 | P            |         000000103 | Jan            |       20090428 |               6030 | 1XA3600 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_verblijfplaats'
      | pl_id | volg_nr | inschrijving_gemeente_code |
      | Jan   |       0 |                       0518 |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | familie_betrek_start_datum | akte_nr | burger_service_nr | geslachts_naam | geboorte_datum | geslachts_aand |
      | Jan   |         0 |       0 |            1 |                   20090428 | 1XA3600 |         000000101 | Petra          |       19880430 | V              |
    En heeft persoon 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
      | pl_id | stapel_nr | volg_nr | persoon_type | akte_nr | geldigheid_start_datum |
      | Jan   |         0 |       0 |            2 | 1XA3600 |               20090428 |
