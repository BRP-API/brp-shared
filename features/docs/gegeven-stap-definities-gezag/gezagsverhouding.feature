# language: nl
@integratie @stap-documentatie
Functionaliteit: Stap definities ten behoeve van specificeren gezagsrelaties

  Achtergrond:
    Gegeven de tabel 'lo3_pl' bevat geen rijen
    En de tabel 'lo3_pl_persoon' bevat geen rijen

  Regel: Gezag toegewezen in een gerechtelijke uitspraak vult minderjarige_gezag_ind en geldigheid_start_datum in
  
  @integratie
  Scenario: {relatievedatum} is in een gerechtelijke uitspraak het gezag toegewezen aan <gezaghebbende in stapdefinitie>
    Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
    En de persoon 'Tosca' met burgerservicenummer '000000024'
    En de persoon 'Theo' met burgerservicenummer '000000036'
    * heeft 'Arjan' en 'Tosca' als ouders
    En <relatieve datum> is in een gerechtelijke uitspraak het gezag toegewezen aan <gezaghebbende>
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     1 |          0 |
    En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
      |     1 | P            |         0 |       0 |         000000012 | Arjan          |               6030 | 1AA0100 |
      |     1 | K            |         0 |       0 |         000000036 | Theo           |                    | 1AA0100 |
    En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     2 |          0 |
    En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
      |     2 | P            |         0 |       0 |         000000024 | Tosca          |               6030 | 1AA0100 |
      |     2 | K            |         0 |       0 |         000000036 | Theo           |                    | 1AA0100 |
    En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
      | pl_id | geheim_ind |
      |     3 |          0 |
    En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
      | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
      |     3 | P            |         0 |       0 |         000000036 | Theo           |               6030 | 1AA0100 |                            |
      |     3 |            1 |         0 |       0 |         000000012 | Arjan          |                    | 1AA0100 | gisteren - 17 jaar         |
      |     3 |            2 |         0 |       0 |         000000024 | Tosca          |                    | 1AA0100 | gisteren - 17 jaar         |
    En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_gezagsverhouding'
      | pl_id | volg_nr | minderjarig_gezag_ind | geldigheid_start_datum |
      |     3 |       0 | <indicatie gezag>     | <relatieve datum>      |

    Voorbeelden:
      | relatieve datum   | gezaghebbende         | indicatie gezag | gezaghebbende in stapdefinitie |
      |    6 jaar geleden | 'Arjan'               |               1 | '{naam}'                       |
      | vorige maand      | 'Tosca'               |               2 | '{naam}'                       |
      | gisteren - 5 jaar | een voogdijinstelling | D               | een voogdijinstelling          |
      | gisteren - 4 jaar | een derde             | D               | een derde                      |
      |    2 jaar geleden | beide ouders          |              12 | beide ouders                   |
      |    2 jaar geleden | 'Arjan' en een derde  |              1D | '{naam}' en een derde          |
      |    2 jaar geleden | 'Tosca' en een derde  |              2D | '{naam}' en een derde          |
