# language: nl
@integratie @stap-documentatie
Functionaliteit: Stap definities ten behoeve van specificeren gezagsrelaties

  Achtergrond:
    Gegeven de tabel 'lo3_pl' bevat geen rijen
    En de tabel 'lo3_pl_persoon' bevat geen rijen

  Regel: Inschrijving, immigratie en emigratie wordt vastgelegd in de verblijfplaats

    @integratie
    Scenario: is ingeschreven in een Nederlandse gemeente
      Gegeven de persoon 'Tosca' met burgerservicenummer '000000012'
      * is ingeschreven in een Nederlandse gemeente
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        |     1 | P            |         0 |       0 |         000000012 | Tosca          |               6030 | 1AA0100 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_verblijfplaats'
        | pl_id | volg_nr | inschrijving_gemeente_code |
        |     1 |       0 |                       0518 |

    @integratie
    Scenario: is ingeschreven als niet-ingezetene met een verblijfplaats in België
      Gegeven de persoon 'Tosca' met burgerservicenummer '000000012'
      * is ingeschreven als niet-ingezetene met een verblijfplaats in België
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        |     1 | P            |         0 |       0 |         000000012 | Tosca          |               6030 | 1AA0100 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_verblijfplaats'
        | pl_id | volg_nr | inschrijving_gemeente_code | vertrek_land_code |
        |     1 |       0 |                       1999 |              5010 |

    @integratie
    Scenario: is ingeschreven als niet-ingezetene met een volledig onbekende verblijfplaats
      Gegeven de persoon 'Tosca' met burgerservicenummer '000000012'
      * is ingeschreven als niet-ingezetene met een volledig onbekende verblijfplaats
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        |     1 | P            |         0 |       0 |         000000012 | Tosca          |               6030 | 1AA0100 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_verblijfplaats'
        | pl_id | volg_nr | inschrijving_gemeente_code | vertrek_land_code |
        |     1 |       0 |                       1999 |              0000 |

    @integratie
    Scenario: de gemeente heeft vastgesteld dat de minderjarige niet op het adres verblijft
      Gegeven de persoon 'Tosca' met burgerservicenummer '000000012'
      * is ingeschreven in een Nederlandse gemeente
      * de gemeente heeft vastgesteld dat de minderjarige niet op het adres verblijft
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        |     1 | P            |         0 |       0 |         000000012 | Tosca          |               6030 | 1AA0100 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_verblijfplaats'
        | pl_id | volg_nr | inschrijving_gemeente_code | onderzoek_gegevens_aand |
        |     1 |       0 |                       0518 |                  089999 |

    @integratie
    Scenario: is op {datum} geïmmigreerd
      # datum heeft formaat d-m-j, met d en m heeft 1 of 2 cijfers, j heeft 4 cijfers
      Gegeven de persoon 'Tosca' met burgerservicenummer '000000012'
      * is geboren in België
      En is op <immigratiedatum> geïmmigreerd
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code |
        |     1 | P            |         0 |       0 |         000000012 | Tosca          |               5010 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_verblijfplaats'
        | pl_id | volg_nr | inschrijving_gemeente_code | vestiging_datum   |
        |     1 |       0 |                       0518 | <vestiging datum> |

      Voorbeelden:
        | immigratiedatum | vestiging datum |
        |       15-5-2022 |        20220515 |
        |       3-11-2023 |        20231103 |

    @integratie
    Scenario: '{naam}' is {relatievedatum} geïmmigreerd naar Nederland
      Gegeven de persoon 'Tosca' met burgerservicenummer '000000012'
      En 'Tosca' is <relatieve datum> geïmmigreerd naar Nederland
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam |
        |     1 | P            |         0 |       0 |         000000012 | Tosca          |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_verblijfplaats'
        | pl_id | volg_nr | inschrijving_gemeente_code | vestiging_datum   |
        |     1 |       0 |                       0518 | <relatieve datum> |

      Voorbeelden:
        | relatieve datum |
        | gisteren        |
        |  2 jaar geleden |
        | vorige maand    |

    @integratie
    Scenario: '{naam}' is {relatievedatum} geëmigreerd naar {landnaam}
      Gegeven de persoon 'Tosca' met burgerservicenummer '000000012'
      En 'Tosca' is <relatieve datum> geëmigreerd naar <land naam>
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam |
        |     1 | P            |         0 |       0 |         000000012 | Tosca          |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_verblijfplaats'
        | pl_id | volg_nr | inschrijving_gemeente_code | vertrek_datum     | vertrek_land_code |
        |     1 |       0 |                       1999 | <relatieve datum> | <land code>       |

      Voorbeelden:
        | relatieve datum | land naam   | land code |
        | vorige maand    | België      |      5010 |
        |  2 jaar geleden | Spanje      |      6037 |
        |  2 jaar geleden | Duitsland   |      6029 |
        |  2 jaar geleden | Afghanistan |      6023 |

    @integratie
    Scenario: neem land mee van vorige verblijfplaats: '{naam}' is {relatievedatum} geïmmigreerd naar Nederland
      Gegeven de persoon 'Tosca' met burgerservicenummer '000000012'
      En 'Tosca' is 2 jaar geleden geëmigreerd naar <land naam>
      En 'Tosca' is 1 jaar geleden geïmmigreerd naar Nederland
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam |
        |     1 | P            |         0 |       0 |         000000012 | Tosca          |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_verblijfplaats'
        | pl_id | volg_nr | inschrijving_gemeente_code | vertrek_datum  | vertrek_land_code | vestiging_datum | vestiging_land_code |
        |     1 |       0 |                       0518 |                |                   |  1 jaar geleden | <land code>         |
        |     1 |       1 |                       1999 | 2 jaar geleden | <land code>       |                 |                     |

      Voorbeelden:
        | land naam   | land code |
        | België      |      5010 |
        | Spanje      |      6037 |
        | Duitsland   |      6029 |
        | Afghanistan |      6023 |
