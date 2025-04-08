# language: nl
@integratie @stap-documentatie
Functionaliteit: Stap definities ten behoeve van specificeren gezagsrelaties

  Achtergrond:
    Gegeven de tabel 'lo3_pl' bevat geen rijen
    En de tabel 'lo3_pl_persoon' bevat geen rijen

  Regel: Ouders worden toegevoegd als persoon_type respectievelijk '1' en '2' aan de persoon en de persoon als persoon_type 'K' bij de ouders

    @integratie
    Scenario: heeft '{naam}' als ouder
      # als er nog geen geboortedatum van de persoon bekend is, wordt 'gisteren - 17 jaar' opgenomen bij familie_betrek_start_datum in de ouder-relatie
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      En de persoon 'Theo' met burgerservicenummer '000000036'
      * heeft 'Arjan' als ouder
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        |     1 | P            |         0 |       0 |         000000012 | Arjan          |               6030 | 1AA0100 |
        |     1 | K            |         0 |       0 |         000000036 | Theo           |                    | 1AA0100 |
      En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        |     2 | P            |         0 |       0 |         000000036 | Theo           |               6030 | 1AA0100 |                            |
        |     2 |            1 |         0 |       0 |         000000012 | Arjan          |                    | 1AA0100 | gisteren - 17 jaar         |

    @integratie
    Abstract Scenario: neem geboortedatum van de minderjarige over: heeft '{naam}' als ouder
      # geboortedatumm wordt overgenomen naar de kind-relatie op de PL van de ouder
      # en familie_betrek_start_datum wordt gevuld met de geboortedatum
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      En de persoon 'Theo' met burgerservicenummer '000000036'
      * <eigenschap kind>
      * heeft 'Arjan' als ouder
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | akte_nr |
        |     1 | P            |         0 |       0 |         000000012 | Arjan          |                 |               6030 | 1AA0100 |
        |     1 | K            |         0 |       0 |         000000036 | Theo           | <geboortedatum> |                    | 1AA0100 |
      En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        |     2 | P            |         0 |       0 |         000000036 | Theo           | <geboortedatum>    |               6030 | 1AA0100 |                            |
        |     2 |            1 |         0 |       0 |         000000012 | Arjan          | gisteren - 45 jaar |                    | 1AA0100 | <geboortedatum>            |

      Voorbeelden:
        | eigenschap kind        | geboortedatum      |
        | is meerderjarig        | gisteren - 45 jaar |
        | is minderjarig         | gisteren - 17 jaar |
        | is geboren op 5-8-1998 |           19980805 |

    @integratie
    Scenario: neem geboortedatum van de ouder over: heeft '{naam}' als ouder
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      * <eigenschap ouder>
      En de persoon 'Theo' met burgerservicenummer '000000036'
      * heeft 'Arjan' als ouder
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | akte_nr |
        |     1 | P            |         0 |       0 |         000000012 | Arjan          | <geboortedatum> |               6030 | 1AA0100 |
        |     1 | K            |         0 |       0 |         000000036 | Theo           |                 |                    | 1AA0100 |
      En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        |     2 | P            |         0 |       0 |         000000036 | Theo           |                 |               6030 | 1AA0100 |                            |
        |     2 |            1 |         0 |       0 |         000000012 | Arjan          | <geboortedatum> |                    | 1AA0100 | gisteren - 17 jaar         |

      Voorbeelden:
        | eigenschap ouder       | geboortedatum      |
        | is meerderjarig        | gisteren - 45 jaar |
        | is minderjarig         | gisteren - 17 jaar |
        | is geboren op 5-8-1998 |           19980805 |

    @integratie
    Scenario: neem geslacht van de ouder over: heeft '{naam}' als ouder
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      * <eigenschap ouder>
      En de persoon 'Theo' met burgerservicenummer '000000036'
      * heeft 'Arjan' als ouder
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | geslachts_aand        |
        |     1 | P            |         0 |       0 |         000000012 | Arjan          |               6030 | 1AA0100 | <geslachtsaanduiding> |
        |     1 | K            |         0 |       0 |         000000036 | Theo           |                    | 1AA0100 |                       |
      En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum | geslachts_aand        |
        |     2 | P            |         0 |       0 |         000000036 | Theo           |               6030 | 1AA0100 |                            |                       |
        |     2 |            1 |         0 |       0 |         000000012 | Arjan          |                    | 1AA0100 | gisteren - 17 jaar         | <geslachtsaanduiding> |

      Voorbeelden:
        | eigenschap ouder | geslachtsaanduiding |
        | is een vrouw     | V                   |
        | is een man       | M                   |

    @integratie
    Scenario: heeft '{naam1}' en '{naam2}' als ouders
      # als er nog geen geboortedatum van de persoon bekend is, wordt default 'gisteren - 17 jaar' opgenomen bij familie_betrek_start_datum in de ouder-relatie
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      En de persoon 'Tosca' met burgerservicenummer '000000024'
      En de persoon 'Theo' met burgerservicenummer '000000036'
      * heeft 'Arjan' en 'Tosca' als ouders
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

    @integratie
    Scenario: overnemen gegevens van ouders en kind: heeft '{naam1}' en '{naam2}' als ouders
      # geboortedatumm van het kind wordt overgenomen naar de kind-relatie op de PL van de ouder en familie_betrek_start_datum wordt gevuld met de geboortedatum
      # geboortedatum en geslacht van de ouder worden overgenomen naar de ouder-relatie op de PL van de persoon
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      * is meerderjarig
      * is een man
      En de persoon 'Tosca' met burgerservicenummer '000000024'
      * is geboren op 5-8-1988
      * is een vrouw
      En de persoon 'Theo' met burgerservicenummer '000000036'
      * is 2 jaar geleden geboren
      * heeft 'Arjan' en 'Tosca' als ouders
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | geslachts_aand | akte_nr |
        |     1 | P            |         0 |       0 |         000000012 | Arjan          | gisteren - 45 jaar |               6030 | M              | 1AA0100 |
        |     1 | K            |         0 |       0 |         000000036 | Theo           |     2 jaar geleden |                    |                | 1AA0100 |
      En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum | geboorte_land_code | geslachts_aand | akte_nr |
        |     2 | P            |         0 |       0 |         000000024 | Tosca          |       19880805 |               6030 | V              | 1AA0100 |
        |     2 | K            |         0 |       0 |         000000036 | Theo           | 2 jaar geleden |                    |                | 1AA0100 |
      En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     3 |          0 |
      En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | geslachts_aand | akte_nr | familie_betrek_start_datum |
        |     3 | P            |         0 |       0 |         000000036 | Theo           |     2 jaar geleden |               6030 |                | 1AA0100 |                            |
        |     3 |            1 |         0 |       0 |         000000012 | Arjan          | gisteren - 45 jaar |                    | M              | 1AA0100 |             2 jaar geleden |
        |     3 |            2 |         0 |       0 |         000000024 | Tosca          |           19880805 |                    | V              | 1AA0100 |             2 jaar geleden |

    @integratie
    Scenario: heeft '{naam}' als ouder die niet met burgerservicenummer is ingeschreven in de BRP
      # geboortedatum van de niet-ingezeten ouder wordt standaard gevuld als meerderjarig (gisteren - 45 jaar)
      # mogelijk gaan we later andere varianten toevoegen (minderjarige ouder) of extra gegevens toevoegen (voornamen, geboorteplaats, geboorteland, ...?)
      # als er nog geen geboortedatum van de persoon bekend is, wordt 'gisteren - 17 jaar' opgenomen bij familie_betrek_start_datum in de ouder-relatie
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      En de persoon 'Theo' met burgerservicenummer '000000036'
      * heeft 'Arjan' als ouder
      * heeft 'Tosca' als ouder die niet met burgerservicenummer is ingeschreven in de BRP
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        |     1 | P            |         0 |       0 |         000000012 | Arjan          |               6030 | 1AA0100 |
        |     1 | K            |         0 |       0 |         000000036 | Theo           |                    | 1AA0100 |
      En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        |     2 | P            |         0 |       0 |         000000036 | Theo           |                    |               6030 | 1AA0100 |                            |
        |     2 |            1 |         0 |       0 |         000000012 | Arjan          | gisteren - 45 jaar |                    | 1AA0100 | gisteren - 17 jaar         |
        |     2 |            2 |         0 |       0 |                   | Tosca          | gisteren - 45 jaar |                    | 1AA0100 | gisteren - 17 jaar         |

    @integratie
    Scenario: overnemen van gegevens van ouder en kind: '{naam}' is op {datum} geadopteerd door '{naam}' en '{naam}'
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      * is meerderjarig
      * is een man
      En de persoon 'Tosca' met burgerservicenummer '000000024'
      * is 18 jaar geleden geboren
      * is een vrouw
      En de persoon 'Theo' met burgerservicenummer '000000036'
      * is minderjarig
      * is geboren in Duitsland
      En 'Theo' is op 30-11-2019 geadopteerd door 'Tosca' en 'Arjan'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | geslachts_aand | akte_nr |
        |     1 | P            |         0 |       0 |         000000012 | Arjan          | gisteren - 45 jaar |               6030 | M              | 1AA0100 |
        |     1 | K            |         0 |       0 |         000000036 | Theo           | gisteren - 17 jaar |                    |                | 1AQ0100 |
      En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | geslachts_aand | akte_nr |
        |     2 | P            |         0 |       0 |         000000024 | Tosca          |    18 jaar geleden |               6030 | V              | 1AA0100 |
        |     2 | K            |         0 |       0 |         000000036 | Theo           | gisteren - 17 jaar |                    |                | 1AQ0100 |
      En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     3 |          0 |
      En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geslachts_aand | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        |     3 | P            |         0 |       0 |         000000036 | Theo           | gisteren - 17 jaar |                |               6029 | 1AQ0100 |                            |
        |     3 |            1 |         0 |       0 |         000000024 | Tosca          |    18 jaar geleden | V              |                    | 1AQ0100 |                   20191130 |
        |     3 |            2 |         0 |       0 |         000000012 | Arjan          | gisteren - 45 jaar | M              |                    | 1AQ0100 |                   20191130 |

    Scenario: '{naam}' is geadopteerd door '{naam}'
      # logica is gelijk aan stap '{naam}' is {relatieve datum} geadopteerd door '{naam}' (voor bepalen ouder 1 of 2 en voor overnemen van gegevens)
      # default datum adoptie is '10 jaar geleden'
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      En de persoon 'Tosca' met burgerservicenummer '000000024'
      En de persoon 'Theo' met burgerservicenummer '000000036'
      * is minderjarig
      * is geboren in Duitsland
      * heeft 'Tosca' als ouder
      En 'Theo' is geadopteerd door 'Arjan'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        |     1 | P            |         0 |       0 |         000000012 | Arjan          |               6030 | 1AA0100 |
        |     1 | K            |         0 |       0 |         000000036 | Theo           |                    | 1AQ0100 |
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
        |     3 | P            |         0 |       0 |         000000036 | Theo           |               6029 | 1AQ0100 |                            |
        |     3 |            1 |         0 |       0 |         000000024 | Tosca          |                    | 1AA0100 | gisteren - 17 jaar         |
        |     3 |            2 |         0 |       0 |         000000012 | Arjan          |                    | 1AQ0100 |            10 jaar geleden |

    @integratie
    Scenario: '{naam}' is geadopteerd door '{naam}' en '{naam}'
      # logica is gelijk aan stap '{naam}' is {relatieve datum} geadopteerd door '{naam}' en '{naam}' (voor overnemen van gegevens)
      # default datum adoptie is '10 jaar geleden'
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      En de persoon 'Tosca' met burgerservicenummer '000000024'
      En de persoon 'Theo' met burgerservicenummer '000000036'
      En 'Theo' is geadopteerd door 'Tosca' en 'Arjan'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        |     1 | P            |         0 |       0 |         000000012 | Arjan          |               6030 | 1AA0100 |
        |     1 | K            |         0 |       0 |         000000036 | Theo           |                    | 1AQ0100 |
      En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        |     2 | P            |         0 |       0 |         000000024 | Tosca          |               6030 | 1AA0100 |
        |     2 | K            |         0 |       0 |         000000036 | Theo           |                    | 1AQ0100 |
      En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     3 |          0 |
      En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        |     3 | P            |         0 |       0 |         000000036 | Theo           |               6030 | 1AQ0100 |                            |
        |     3 |            1 |         0 |       0 |         000000024 | Tosca          |                    | 1AQ0100 |            10 jaar geleden |
        |     3 |            2 |         0 |       0 |         000000012 | Arjan          |                    | 1AQ0100 |            10 jaar geleden |

    @integratie
    Scenario: '{naam}' is erkend door '{naam}' op {datum}
      Gegeven de tabel 'lo3_pl_persoon' bevat geen rijen
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      * is meerderjarig
      En de persoon 'Tosca' met burgerservicenummer '000000024'
      * is meerderjarig
      En de persoon 'Theo' met burgerservicenummer '000000036'
      * is minderjarig
      * heeft 'Tosca' als ouder
      En 'Theo' is erkend door 'Arjan' op 16-5-2021
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geboorte_datum     | geslachts_naam | geboorte_land_code | akte_nr |
        |     1 | P            |         0 |       0 |         000000012 | gisteren - 45 jaar | Arjan          |               6030 | 1AA0100 |
        |     1 | K            |         0 |       0 |         000000036 | gisteren - 17 jaar | Theo           |                    | 1AC0100 |
      En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geboorte_datum     | geslachts_naam | geboorte_land_code | akte_nr |
        |     2 | P            |         0 |       0 |         000000024 | gisteren - 45 jaar | Tosca          |               6030 | 1AA0100 |
        |     2 | K            |         0 |       0 |         000000036 | gisteren - 17 jaar | Theo           |                    | 1AA0100 |
      En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     3 |          0 |
      En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        |     3 | P            |         0 |       0 |         000000036 | Theo           | gisteren - 17 jaar |               6030 | 1AC0100 |                            |
        |     3 |            1 |         0 |       0 |         000000024 | Tosca          | gisteren - 45 jaar |                    | 1AA0100 | gisteren - 17 jaar         |
        |     3 |            2 |         0 |       0 |         000000012 | Arjan          | gisteren - 45 jaar |                    | 1AC0100 |                   20210516 |

    Scenario: overnemen gegevens van ouder en kind: '{naam}' is erkend door '{naam}' op {datum}
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      * is meerderjarig
      * is een man
      En de persoon 'Tosca' met burgerservicenummer '000000024'
      En de persoon 'Theo' met burgerservicenummer '000000036'
      * is minderjarig
      * heeft 'Tosca' als ouder
      En 'Theo' is erkend door 'Arjan' op 16-5-2021
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geboorte_datum     | geslachts_naam | geboorte_land_code | geslachts_aand | akte_nr |
        |     1 | P            |         0 |       0 |         000000012 | gisteren - 45 jaar | Arjan          |               6030 | M              | 1AA0100 |
        |     1 | K            |         0 |       0 |         000000036 | gisteren - 17 jaar | Theo           |                    |                | 1AC0100 |
      En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geboorte_datum     | geslachts_naam | geboorte_land_code | akte_nr |
        |     2 | P            |         0 |       0 |         000000024 |                    | Tosca          |               6030 | 1AA0100 |
        |     2 | K            |         0 |       0 |         000000036 | gisteren - 17 jaar | Theo           |                    | 1AA0100 |
      En heeft de persoon 'Theo' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     3 |          0 |
      En heeft de persoon 'Theo' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | geslachts_aand | akte_nr | familie_betrek_start_datum |
        |     3 | P            |         0 |       0 |         000000036 | Theo           | gisteren - 17 jaar |               6030 |                | 1AC0100 |                            |
        |     3 |            1 |         0 |       0 |         000000024 | Tosca          | gisteren - 45 jaar |                    |                | 1AA0100 | gisteren - 17 jaar         |
        |     3 |            2 |         0 |       0 |         000000012 | Arjan          | gisteren - 45 jaar |                    | M              | 1AC0100 |                   20210516 |

  Regel: Een gerechtelijke uitspraak wordt vastgelegd in de gezagsverhouding

    Scenario: <stapdefinitie>
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      En de persoon 'Tosca' met burgerservicenummer '000000024'
      En de persoon 'Theo' met burgerservicenummer '000000036'
      * heeft 'Arjan' en 'Tosca' als ouders
      En in een gerechtelijke uitspraak is <gezag uitspraak>
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
        |     3 |       0 | <indicatie gezag>     | gisteren - 1 jaar      |

      Voorbeelden:
        | gezag uitspraak                               | indicatie gezag | stapdefinitie                                                                    |
        | het gezag toegewezen aan 'Arjan'              |               1 | in een gerechtelijke uitspraak is het gezag toegewezen aan '{naam}'              |
        | het gezag toegewezen aan 'Tosca'              |               2 | in een gerechtelijke uitspraak is het gezag toegewezen aan '{naam}'              |
        | het gezag toegewezen aan beide ouders         |              12 | in een gerechtelijke uitspraak is het gezag toegewezen aan beide ouders          |
        | een voogdijinstelling tot voogd benoemd       | D               | in een gerechtelijke uitspraak is een voogdijinstelling tot voogd benoemd        |
        | een derde tot voogd benoemd                   | D               | in een gerechtelijke uitspraak is een derde tot voogd benoemd                    |
        | het gezag toegewezen aan 'Arjan' en een derde |              1D | in een gerechtelijke uitspraak is het gezag toegewezen aan '{naam}' en een derde |
        | het gezag toegewezen aan 'Tosca' en een derde |              2D | in een gerechtelijke uitspraak is het gezag toegewezen aan '{naam}' en een derde |

  Regel: Curatele wordt vastgelegd in de gezagsverhouding

    Scenario: '{naam}' staat onder curatele
      Gegeven de persoon 'Arjan' met burgerservicenummer '000000012'
      En de persoon 'Tosca' met burgerservicenummer '000000024'
      En 'Arjan' staat onder curatele
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft de persoon 'Arjan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     1 |          0 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        |     1 | P            |         0 |       0 |         000000012 | Arjan          |               6030 | 1AA0100 |
      En heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_gezagsverhouding'
        | pl_id | volg_nr | curatele_register_ind |
        |     1 |       0 |                     1 |
      En heeft de persoon 'Tosca' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        |     2 |          0 |
      En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        |     2 | P            |         0 |       0 |         000000024 | Tosca          |               6030 | 1AA0100 |
