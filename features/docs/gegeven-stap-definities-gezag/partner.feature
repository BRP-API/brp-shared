# language: nl
@integratie @stap-documentatie
Functionaliteit: Stap definities ten behoeve van specificeren gezagsrelaties

  Achtergrond:
    Gegeven de tabel 'lo3_pl' bevat geen rijen
    En de tabel 'lo3_pl_persoon' bevat geen rijen

  Regel: Huwelijk en geregistreerd partnerschap wordt toegevoegd als persoon_type 'R' voor beide betrokken personen
    # To Do: welke gegevens van een persoon worden meegenomen - want zijn relevant - in de relatie?
    # geboortedatum, geboorteland, ...?

    @integratie
    Scenario: '{naam1}' en '{naam2}' zijn met elkaar gehuwd
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      En de persoon 'Tosca' met burgerservicenummer '000000024'
      En 'Arjan' en 'Tosca' zijn met elkaar gehuwd
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
        |     1 | P            |         0 |       0 |         000000012 | Arjan          |               6030 | 1AA0100 |                     |                      |                         |                   |
        |     1 | R            |         0 |       0 |         000000024 | Tosca          |                    |         | gisteren - 20 jaar  |                 0518 |                    6030 | H                 |
      En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
        |     2 | P            |         0 |       0 |         000000024 | Tosca          |               6030 | 1AA0100 |                     |                      |                         |                   |
        |     2 | R            |         0 |       0 |         000000012 | Arjan          |                    |         | gisteren - 20 jaar  |                 0518 |                    6030 | H                 |

    @integratie
    Abstract Scenario: '{naam1}' en '{naam2}' zijn {relatievedatum} gehuwd
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      En de persoon 'Tosca' met burgerservicenummer '000000024'
      En 'Arjan' en 'Tosca' zijn <relatieve datum> gehuwd
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
        |     1 | P            |         0 |       0 |         000000012 | Arjan          |               6030 | 1AA0100 |                     |                      |                         |                   |
        |     1 | R            |         0 |       0 |         000000024 | Tosca          |                    |         | <relatieve datum>   |                 0518 |                    6030 | H                 |
      En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
        |     2 | P            |         0 |       0 |         000000024 | Tosca          |               6030 | 1AA0100 |                     |                      |                         |                   |
        |     2 | R            |         0 |       0 |         000000012 | Arjan          |                    |         | <relatieve datum>   |                 0518 |                    6030 | H                 |

      Voorbeelden:
        | relatieve datum   |
        |    2 jaar geleden |
        | gisteren - 5 jaar |

    @integratie
    Scenario: '{naam1}' en '{naam2}' zijn een geregistreerd partnerschap aangegaan op {datum}
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      En de persoon 'Tosca' met burgerservicenummer '000000024'
      En 'Arjan' en 'Tosca' zijn een geregistreerd partnerschap aangegaan op 1-3-2010
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
        |     1 | P            |         0 |       0 |         000000012 | Arjan          |               6030 | 1AA0100 |                     |                      |                         |                   |
        |     1 | R            |         0 |       0 |         000000024 | Tosca          |                    |         |            20100301 |                 0518 |                    6030 | P                 |
      En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
        |     2 | P            |         0 |       0 |         000000024 | Tosca          |               6030 | 1AA0100 |                     |                      |                         |                   |
        |     2 | R            |         0 |       0 |         000000012 | Arjan          |                    |         |            20100301 |                 0518 |                    6030 | P                 |

    @integratie
    Scenario: '{naam1}' en '{naam2}' zijn {relatieve datum} een geregistreerd partnerschap aangegaan
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      En de persoon 'Tosca' met burgerservicenummer '000000024'
      En 'Arjan' en 'Tosca' zijn 7 jaar geleden een geregistreerd partnerschap aangegaan
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
        |     1 | P            |         0 |       0 |         000000012 | Arjan          |               6030 | 1AA0100 |                     |                      |                         |                   |
        |     1 | R            |         0 |       0 |         000000024 | Tosca          |                    |         |      7 jaar geleden |                 0518 |                    6030 | P                 |
      En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
        |     2 | P            |         0 |       0 |         000000024 | Tosca          |               6030 | 1AA0100 |                     |                      |                         |                   |
        |     2 | R            |         0 |       0 |         000000012 | Arjan          |                    |         |      7 jaar geleden |                 0518 |                    6030 | P                 |

    @integratie
    Abstract Scenario: '{naam1}' en '{naam2}' zijn {relatievedatum} gescheiden
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      En de persoon 'Tosca' met burgerservicenummer '000000024'
      En 'Arjan' en 'Tosca' zijn met elkaar gehuwd
      En 'Arjan' en 'Tosca' zijn <relatieve datum> gescheiden
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        |     1 | P            |         0 |       0 |         000000012 | Arjan          |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        |     1 | R            |         0 |       1 |         000000024 | Tosca          |                    |         | gisteren - 20 jaar  |                 0518 |                    6030 |                    |                     |                        | H                 |
        |     1 | R            |         0 |       0 |         000000024 | Tosca          |                    |         |                     |                      |                         | <relatieve datum>  |                0518 |                   6030 | H                 |
      En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        |     2 | P            |         0 |       0 |         000000024 | Tosca          |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        |     2 | R            |         0 |       1 |         000000012 | Arjan          |                    |         | gisteren - 20 jaar  |                 0518 |                    6030 |                    |                     |                        | H                 |
        |     2 | R            |         0 |       0 |         000000012 | Arjan          |                    |         |                     |                      |                         | <relatieve datum>  |                0518 |                   6030 | H                 |

      Voorbeelden:
        | relatieve datum   |
        |    2 jaar geleden |
        | gisteren - 5 jaar |

    @integratie
    Abstract Scenario: volgende relatie: '{naam1}' en '{naam2}' zijn {relatievedatum} gehuwd
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      En de persoon 'Tosca' met burgerservicenummer '000000024'
      En 'Arjan' en 'Tosca' zijn met elkaar gehuwd
      En 'Arjan' en 'Tosca' zijn 5 jaar geleden gescheiden
      En 'Arjan' en 'Tosca' zijn <relatieve datum> gehuwd
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        |     1 | P            |         0 |       0 |         000000012 | Arjan          |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        |     1 | R            |         0 |       1 |         000000024 | Tosca          |                    |         | gisteren - 20 jaar  |                 0518 |                    6030 |                    |                     |                        | H                 |
        |     1 | R            |         0 |       0 |         000000024 | Tosca          |                    |         |                     |                      |                         |     5 jaar geleden |                0518 |                   6030 | H                 |
        |     1 | R            |         1 |       0 |         000000024 | Tosca          |                    |         | <relatieve datum>   |                 0518 |                    6030 |                    |                     |                        | H                 |
      En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        |     2 | P            |         0 |       0 |         000000024 | Tosca          |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        |     2 | R            |         0 |       1 |         000000012 | Arjan          |                    |         | gisteren - 20 jaar  |                 0518 |                    6030 |                    |                     |                        | H                 |
        |     2 | R            |         0 |       0 |         000000012 | Arjan          |                    |         |                     |                      |                         |     5 jaar geleden |                0518 |                   6030 | H                 |
        |     2 | R            |         1 |       0 |         000000012 | Arjan          |                    |         | <relatieve datum>   |                 0518 |                    6030 |                    |                     |                        | H                 |

      Voorbeelden:
        | relatieve datum   |
        |    2 jaar geleden |
        | gisteren - 3 jaar |
        | vorige maand      |

    @integratie
    Scenario: '{naam1}' en '{naam2}' zijn {relatievedatum1} gehuwd en {relatievedatum2} gescheiden
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      En de persoon 'Tosca' met burgerservicenummer '000000024'
      En 'Arjan' en 'Tosca' zijn 6 jaar geleden gehuwd
      En 'Arjan' en 'Tosca' zijn 2 jaar geleden gescheiden
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        |     1 | P            |         0 |       0 |         000000012 | Arjan          |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        |     1 | R            |         0 |       1 |         000000024 | Tosca          |                    |         |      6 jaar geleden |                 0518 |                    6030 |                    |                     |                        | H                 |
        |     1 | R            |         0 |       0 |         000000024 | Tosca          |                    |         |                     |                      |                         |     2 jaar geleden |                0518 |                   6030 | H                 |
      En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        |     2 | P            |         0 |       0 |         000000024 | Tosca          |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        |     2 | R            |         0 |       1 |         000000012 | Arjan          |                    |         |      6 jaar geleden |                 0518 |                    6030 |                    |                     |                        | H                 |
        |     2 | R            |         0 |       0 |         000000012 | Arjan          |                    |         |                     |                      |                         |     2 jaar geleden |                0518 |                   6030 | H                 |

    @integratie
    Scenario: personen zijn gehuwd, gescheiden en opnieuw gehuwd
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      En de persoon 'Tosca' met burgerservicenummer '000000024'
      En de persoon 'Theo' met burgerservicenummer '000000036'
      En de persoon 'Thea' met burgerservicenummer '000000048'
      En 'Arjan' en 'Tosca' zijn 10 jaar geleden gehuwd
      En 'Arjan' en 'Tosca' zijn 7 jaar geleden gescheiden
      En 'Arjan' en 'Thea' zijn 5 jaar geleden gehuwd
      En 'Tosca' en 'Theo' zijn 3 jaar geleden gehuwd
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        |     1 | P            |         0 |       0 |         000000012 | Arjan          |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        |     1 | R            |         0 |       1 |         000000024 | Tosca          |                    |         |     10 jaar geleden |                 0518 |                    6030 |                    |                     |                        | H                 |
        |     1 | R            |         0 |       0 |         000000024 | Tosca          |                    |         |                     |                      |                         |     7 jaar geleden |                0518 |                   6030 | H                 |
        |     1 | R            |         1 |       0 |         000000048 | Thea           |                    |         |      5 jaar geleden |                 0518 |                    6030 |                    |                     |                        | H                 |
      En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        |     2 | P            |         0 |       0 |         000000024 | Tosca          |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        |     2 | R            |         0 |       1 |         000000012 | Arjan          |                    |         |     10 jaar geleden |                 0518 |                    6030 |                    |                     |                        | H                 |
        |     2 | R            |         0 |       0 |         000000012 | Arjan          |                    |         |                     |                      |                         |     7 jaar geleden |                0518 |                   6030 | H                 |
        |     2 | R            |         1 |       0 |         000000036 | Theo           |                    |         |      3 jaar geleden |                 0518 |                    6030 |                    |                     |                        | H                 |
      En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     3 |          0 |
      En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        |     3 | P            |         0 |       0 |         000000036 | Theo           |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        |     3 | R            |         0 |       0 |         000000024 | Tosca          |                    |         |      3 jaar geleden |                 0518 |                    6030 |                    |                     |                        | H                 |
      En heeft de persoon 'Thea' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     4 |          0 |
      En heeft de persoon 'Thea' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | relatie_eind_datum | relatie_eind_plaats | relatie_eind_land_code | verbintenis_soort |
        |     4 | P            |         0 |       0 |         000000048 | Thea           |               6030 | 1AA0100 |                     |                      |                         |                    |                     |                        |                   |
        |     4 | R            |         0 |       0 |         000000012 | Arjan          |                    |         |      5 jaar geleden |                 0518 |                    6030 |                    |                     |                        | H                 |
