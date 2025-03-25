# language: nl
@integratie @stap-documentatie
Functionaliteit: Stap definities ten behoeve van specificeren gezagsrelaties

  Achtergrond:
    Gegeven de tabel 'lo3_pl' bevat geen rijen
    En de tabel 'lo3_pl_persoon' bevat geen rijen
    En de tabel 'lo3_pl_verblijfplaats' bevat geen rijen
    En de tabel 'lo3_pl_gezagsverhouding' bevat geen rijen

  Regel: Een persoon benoemen we functioneel met een naam en technisch met een burgerservicenummer
    Standaard is een persoon in Nederland geboren met een Nederlandse geboorteakte.

    Scenario: de persoon '{naam}' met burgerservicenummer '{bsn}'
      Gegeven de persoon 'Tosca' met burgerservicenummer '000000012'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | akte_nr | geboorte_land_code |
        |     1 | P            |         0 |       0 |         000000012 | Tosca          |         |                    |

    Scenario: '{naam}' is minderjarig
      Gegeven de persoon 'Tosca' met burgerservicenummer '000000012'
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000024'
      En persoon 'Tosca'
      * is minderjarig
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | akte_nr | geboorte_land_code |
        |     2 | P            |         0 |       0 |         000000012 | Tosca          | gisteren - 17 jaar |         |                    |
      En heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam |akte_nr | geboorte_land_code |
        |     1 | P            |         0 |       0 |         000000024 | Arjan          |        |                    |

    Scenario: '{naam1}' en '{naam2}' zijn {relatieve datum} een geregistreerd partnerschap aangegaan
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      En de persoon 'Tosca' met burgerservicenummer '000000024'
      En 'Arjan' en 'Tosca' zijn 7 jaar geleden een geregistreerd partnerschap aangegaan
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      En heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
        |     1 | P            |         0 |       0 |         000000012 | Arjan          |                    |         |                     |                      |                         |                   |
        |     1 | R            |         0 |       0 |         000000024 | Tosca          |                    |         |      7 jaar geleden |                 0518 |                    6030 | P                 |
      Dan heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
        |     2 | P            |         0 |       0 |         000000024 | Tosca          |                    |         |                     |                      |                         |                   |
        |     2 | R            |         0 |       0 |         000000012 | Arjan          |                    |         |      7 jaar geleden |                 0518 |                    6030 | P                 |
