# language: nl
@integratie @stap-documentatie
Functionaliteit: Stap definities ten behoeve van specificeren gezagsrelaties

  Achtergrond:
    Gegeven de tabel 'lo3_pl' bevat geen rijen
    En de tabel 'lo3_pl_persoon' bevat geen rijen

  Regel: Geslachtsaanduiding wordt toegevoegd aan de persoon

    @integratie
    Scenario: is een <geslacht>
      Gegeven de persoon 'Tosca' met burgerservicenummer '000000012'
      * is een <geslacht>
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | geslachts_aand        |
        |     1 | P            |         0 |       0 |         000000012 | Tosca          |               6030 | 1AA0100 | <geslacht aanduiding> |

      Voorbeelden:
        | geslacht | geslacht aanduiding |
        | vrouw    | V                   |
        | man      | M                   |
