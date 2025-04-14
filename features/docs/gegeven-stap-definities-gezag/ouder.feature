# language: nl
@integratie @stap-documentatie
Functionaliteit: Stap definities ten behoeve van specificeren gezagsrelaties

  Regel: Ouders worden toegevoegd als persoon_type respectievelijk '1' en '2' aan de persoon en de persoon als persoon_type 'K' bij de ouders

    @integratie
    Scenario: heeft '{naam}' als ouder
      # als er nog geen geboortedatum van de persoon bekend is, wordt 'gisteren - 17 jaar' opgenomen bij familie_betrek_start_datum in de ouder-relatie
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000036'
      * heeft 'P1' als ouder
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P2             |                    | 1AA0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P2    | P            |         0 |       0 |         000000036 | P2             |               6030 | 1AA0100 |                            |
        | P2    |            1 |         0 |       0 |         000000012 | P1             |                    | 1AA0100 | gisteren - 17 jaar         |

    @integratie
    Abstract Scenario: neem geboortedatum van de minderjarige over: heeft '{naam}' als ouder
      # geboortedatumm wordt overgenomen naar de kind-relatie op de PL van de ouder
      # en familie_betrek_start_datum wordt gevuld met de geboortedatum
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000036'
      * <eigenschap kind>
      * heeft 'P1' als ouder
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |                 |               6030 | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P2             | <geboortedatum> |                    | 1AA0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P2    | P            |         0 |       0 |         000000036 | P2             | <geboortedatum>    |               6030 | 1AA0100 |                            |
        | P2    |            1 |         0 |       0 |         000000012 | P1             | gisteren - 45 jaar |                    | 1AA0100 | <geboortedatum>            |

      Voorbeelden:
        | eigenschap kind        | geboortedatum      |
        | is meerderjarig        | gisteren - 45 jaar |
        | is minderjarig         | gisteren - 17 jaar |
        | is geboren op 5-8-1998 |           19980805 |

    @integratie
    Scenario: neem geboortedatum van de ouder over: heeft '{naam}' als ouder
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * <eigenschap ouder>
      En de persoon 'P2' met burgerservicenummer '000000036'
      * heeft 'P1' als ouder
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             | <geboortedatum> |               6030 | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P2             |                 |                    | 1AA0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum  | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P2    | P            |         0 |       0 |         000000036 | P2             |                 |               6030 | 1AA0100 |                            |
        | P2    |            1 |         0 |       0 |         000000012 | P1             | <geboortedatum> |                    | 1AA0100 | gisteren - 17 jaar         |

      Voorbeelden:
        | eigenschap ouder       | geboortedatum      |
        | is meerderjarig        | gisteren - 45 jaar |
        | is minderjarig         | gisteren - 17 jaar |
        | is geboren op 5-8-1998 |           19980805 |

    @integratie
    Scenario: neem geslacht van de ouder over: heeft '{naam}' als ouder
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * <eigenschap ouder>
      En de persoon 'P2' met burgerservicenummer '000000036'
      * heeft 'P1' als ouder
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | geslachts_aand        |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 | <geslachtsaanduiding> |
        | P1    | K            |         0 |       0 |         000000036 | P2             |                    | 1AA0100 |                       |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum | geslachts_aand        |
        | P2    | P            |         0 |       0 |         000000036 | P2             |               6030 | 1AA0100 |                            |                       |
        | P2    |            1 |         0 |       0 |         000000012 | P1             |                    | 1AA0100 | gisteren - 17 jaar         | <geslachtsaanduiding> |

      Voorbeelden:
        | eigenschap ouder | geslachtsaanduiding |
        | is een vrouw     | V                   |
        | is een man       | M                   |

    @integratie
    Scenario: heeft '{naam1}' en '{naam2}' als ouders
      # als er nog geen geboortedatum van de persoon bekend is, wordt default 'gisteren - 17 jaar' opgenomen bij familie_betrek_start_datum in de ouder-relatie
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En de persoon 'P3' met burgerservicenummer '000000036'
      * heeft 'P1' en 'P2' als ouders
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P3             |                    | 1AA0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |
        | P2    | K            |         0 |       0 |         000000036 | P3             |                    | 1AA0100 |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             |               6030 | 1AA0100 |                            |
        | P3    |            1 |         0 |       0 |         000000012 | P1             |                    | 1AA0100 | gisteren - 17 jaar         |
        | P3    |            2 |         0 |       0 |         000000024 | P2             |                    | 1AA0100 | gisteren - 17 jaar         |

    @integratie
    Scenario: overnemen gegevens van ouders en kind: heeft '{naam1}' en '{naam2}' als ouders
      # geboortedatumm van het kind wordt overgenomen naar de kind-relatie op de PL van de ouder en familie_betrek_start_datum wordt gevuld met de geboortedatum
      # geboortedatum en geslacht van de ouder worden overgenomen naar de ouder-relatie op de PL van de persoon
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * is meerderjarig
      * is een man
      En de persoon 'P2' met burgerservicenummer '000000024'
      * is geboren op 5-8-1988
      * is een vrouw
      En de persoon 'P3' met burgerservicenummer '000000036'
      * is 2 jaar geleden geboren
      * heeft 'P1' en 'P2' als ouders
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | geslachts_aand | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             | gisteren - 45 jaar |               6030 | M              | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P3             |     2 jaar geleden |                    |                | 1AA0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum | geboorte_land_code | geslachts_aand | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |       19880805 |               6030 | V              | 1AA0100 |
        | P2    | K            |         0 |       0 |         000000036 | P3             | 2 jaar geleden |                    |                | 1AA0100 |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | geslachts_aand | akte_nr | familie_betrek_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             |     2 jaar geleden |               6030 |                | 1AA0100 |                            |
        | P3    |            1 |         0 |       0 |         000000012 | P1             | gisteren - 45 jaar |                    | M              | 1AA0100 |             2 jaar geleden |
        | P3    |            2 |         0 |       0 |         000000024 | P2             |           19880805 |                    | V              | 1AA0100 |             2 jaar geleden |

    @integratie
    Scenario: heeft '{naam}' als ouder die niet met burgerservicenummer is ingeschreven in de BRP
      # geboortedatum van de niet-ingezeten ouder wordt standaard gevuld als meerderjarig (gisteren - 45 jaar)
      # mogelijk gaan we later andere varianten toevoegen (minderjarige ouder) of extra gegevens toevoegen (voornamen, geboorteplaats, geboorteland, ...?)
      # als er nog geen geboortedatum van de persoon bekend is, wordt 'gisteren - 17 jaar' opgenomen bij familie_betrek_start_datum in de ouder-relatie
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000036'
      * heeft 'P1' als ouder
      * heeft 'P3' als ouder die niet met burgerservicenummer is ingeschreven in de BRP
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P2             |                    | 1AA0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P2    | P            |         0 |       0 |         000000036 | P2             |                    |               6030 | 1AA0100 |                            |
        | P2    |            1 |         0 |       0 |         000000012 | P1             | gisteren - 45 jaar |                    | 1AA0100 | gisteren - 17 jaar         |
        | P2    |            2 |         0 |       0 |                   | P3             | gisteren - 45 jaar |                    | 1AA0100 | gisteren - 17 jaar         |

    @integratie
    Scenario: overnemen van gegevens van ouder en kind: '{naam}' is op {datum} geadopteerd door '{naam}' en '{naam}'
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * is meerderjarig
      * is een man
      En de persoon 'P2' met burgerservicenummer '000000024'
      * is 18 jaar geleden geboren
      * is een vrouw
      En de persoon 'P3' met burgerservicenummer '000000036'
      * is minderjarig
      * is geboren in Duitsland
      En 'P3' is op 30-11-2019 geadopteerd door 'P2' en 'P1'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | geslachts_aand | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             | gisteren - 45 jaar |               6030 | M              | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |                    |                | 1AQ0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | geslachts_aand | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |    18 jaar geleden |               6030 | V              | 1AA0100 |
        | P2    | K            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |                    |                | 1AQ0100 |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geslachts_aand | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |                |               6029 | 1AQ0100 |                            |
        | P3    |            1 |         0 |       0 |         000000024 | P2             |    18 jaar geleden | V              |                    | 1AQ0100 |                   20191130 |
        | P3    |            2 |         0 |       0 |         000000012 | P1             | gisteren - 45 jaar | M              |                    | 1AQ0100 |                   20191130 |

    @integratie
    Scenario: '{naam}' is geadopteerd door '{naam}'
      # logica is gelijk aan stap '{naam}' is {relatieve datum} geadopteerd door '{naam}' (voor bepalen ouder 1 of 2 en voor overnemen van gegevens)
      # default datum adoptie is '10 jaar geleden'
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En de persoon 'P3' met burgerservicenummer '000000036'
      * is minderjarig
      * is geboren in Duitsland
      * heeft 'P2' als ouder
      En 'P3' is geadopteerd door 'P1'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P3             |                    | 1AQ0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |
        | P2    | K            |         0 |       0 |         000000036 | P3             |                    | 1AA0100 |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             |               6029 | 1AQ0100 |                            |
        | P3    |            1 |         0 |       0 |         000000024 | P2             |                    | 1AA0100 | gisteren - 17 jaar         |
        | P3    |            2 |         0 |       0 |         000000012 | P1             |                    | 1AQ0100 |            10 jaar geleden |

    @integratie
    Scenario: '{naam}' is geadopteerd door '{naam}' en '{naam}'
      # logica is gelijk aan stap '{naam}' is {relatieve datum} geadopteerd door '{naam}' en '{naam}' (voor overnemen van gegevens)
      # default datum adoptie is '10 jaar geleden'
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En de persoon 'P3' met burgerservicenummer '000000036'
      En 'P3' is geadopteerd door 'P2' en 'P1'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P3             |                    | 1AQ0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |
        | P2    | K            |         0 |       0 |         000000036 | P3             |                    | 1AQ0100 |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             |               6030 | 1AQ0100 |                            |
        | P3    |            1 |         0 |       0 |         000000024 | P2             |                    | 1AQ0100 |            10 jaar geleden |
        | P3    |            2 |         0 |       0 |         000000012 | P1             |                    | 1AQ0100 |            10 jaar geleden |

    @integratie
    Scenario: '{naam}' is {relatieve datum} geadopteerd door '{naam}'
      # het soort ouder (persoon_type '1' of '2') is de eerste plek die beschikbaar is
      # als er nog geen ouder 1 is dan wordt de adoptieouder ouder 1
      Gegeven de persoon 'P1' met burgerservicenummer '000000024'
      En de persoon 'P2' met burgerservicenummer '000000036'
      En 'P2' is 3 jaar geleden geadopteerd door 'P1'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000024 | P1             |               6030 | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P2             |                    | 1AQ0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P2    | P            |         0 |       0 |         000000036 | P2             |               6030 | 1AQ0100 |                            |
        | P2    |            1 |         0 |       0 |         000000024 | P1             |                    | 1AQ0100 |             3 jaar geleden |

    @integratie
    Scenario: adoptie naast andere ouder: '{naam}' is {relatieve datum} geadopteerd door '{naam}'
      # het soort ouder (persoon_type '1' of '2') is de eerste plek die beschikbaar is
      # als ouder 1 al bestaat en ouder 1 heeft geslachts_naam met een waarde ongelijk aan '.', dan wordt de adoptieouder ouder 2
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En de persoon 'P3' met burgerservicenummer '000000036'
      * heeft 'P2' als ouder
      En 'P3' is 3 jaar geleden geadopteerd door 'P1'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P3             |                    | 1AQ0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |
        | P2    | K            |         0 |       0 |         000000036 | P3             |                    | 1AA0100 |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             |               6030 | 1AQ0100 |                            |
        | P3    |            1 |         0 |       0 |         000000024 | P2             |                    | 1AA0100 | gisteren - 17 jaar         |
        | P3    |            2 |         0 |       0 |         000000012 | P1             |                    | 1AQ0100 |             3 jaar geleden |

    @integratie
    Scenario: '{naam}' is erkend door '{naam}' op {datum}
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * is meerderjarig
      En de persoon 'P2' met burgerservicenummer '000000024'
      * is meerderjarig
      En de persoon 'P3' met burgerservicenummer '000000036'
      * is minderjarig
      * heeft 'P2' als ouder
      En 'P3' is erkend door 'P1' op 16-5-2021
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geboorte_datum     | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | gisteren - 45 jaar | P1             |               6030 | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | gisteren - 17 jaar | P3             |                    | 1AC0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geboorte_datum     | geslachts_naam | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | gisteren - 45 jaar | P2             |               6030 | 1AA0100 |
        | P2    | K            |         0 |       0 |         000000036 | gisteren - 17 jaar | P3             |                    | 1AA0100 |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |               6030 | 1AC0100 |                            |
        | P3    |            1 |         0 |       0 |         000000024 | P2             | gisteren - 45 jaar |                    | 1AA0100 | gisteren - 17 jaar         |
        | P3    |            2 |         0 |       0 |         000000012 | P1             | gisteren - 45 jaar |                    | 1AC0100 |                   20210516 |

    @integratie
    Scenario: overnemen gegevens van ouder en kind: '{naam}' is erkend door '{naam}' op {datum}
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * is meerderjarig
      * is een man
      En de persoon 'P2' met burgerservicenummer '000000024'
      En de persoon 'P3' met burgerservicenummer '000000036'
      * is minderjarig
      * heeft 'P2' als ouder
      En 'P3' is erkend door 'P1' op 16-5-2021
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geboorte_datum     | geslachts_naam | geboorte_land_code | geslachts_aand | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | gisteren - 45 jaar | P1             |               6030 | M              | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | gisteren - 17 jaar | P3             |                    |                | 1AC0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geboorte_datum     | geslachts_naam | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 |                    | P2             |               6030 | 1AA0100 |
        | P2    | K            |         0 |       0 |         000000036 | gisteren - 17 jaar | P3             |                    | 1AA0100 |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | geslachts_aand | akte_nr | familie_betrek_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |               6030 |                | 1AC0100 |                            |
        | P3    |            1 |         0 |       0 |         000000024 | P2             | gisteren - 45 jaar |                    |                | 1AA0100 | gisteren - 17 jaar         |
        | P3    |            2 |         0 |       0 |         000000012 | P1             | gisteren - 45 jaar |                    | M              | 1AC0100 |                   20210516 |

  Regel: Een gerechtelijke uitspraak wordt vastgelegd in de gezagsverhouding

    @integratie
    Scenario: <stapdefinitie>
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En de persoon 'P3' met burgerservicenummer '000000036'
      * heeft 'P1' en 'P2' als ouders
      En in een gerechtelijke uitspraak is <gezag uitspraak>
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P3             |                    | 1AA0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |
        | P2    | K            |         0 |       0 |         000000036 | P3             |                    | 1AA0100 |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             |               6030 | 1AA0100 |                            |
        | P3    |            1 |         0 |       0 |         000000012 | P1             |                    | 1AA0100 | gisteren - 17 jaar         |
        | P3    |            2 |         0 |       0 |         000000024 | P2             |                    | 1AA0100 | gisteren - 17 jaar         |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_gezagsverhouding'
        | pl_id | volg_nr | minderjarig_gezag_ind | geldigheid_start_datum |
        | P3    |       0 | <indicatie gezag>     | gisteren - 1 jaar      |

      Voorbeelden:
        | gezag uitspraak                            | indicatie gezag | stapdefinitie                                                                    |
        | het gezag toegewezen aan 'P1'              |               1 | in een gerechtelijke uitspraak is het gezag toegewezen aan '{naam}'              |
        | het gezag toegewezen aan 'P2'              |               2 | in een gerechtelijke uitspraak is het gezag toegewezen aan '{naam}'              |
        | het gezag toegewezen aan beide ouders      |              12 | in een gerechtelijke uitspraak is het gezag toegewezen aan beide ouders          |
        | een voogdijinstelling tot voogd benoemd    | D               | in een gerechtelijke uitspraak is een voogdijinstelling tot voogd benoemd        |
        | een derde tot voogd benoemd                | D               | in een gerechtelijke uitspraak is een derde tot voogd benoemd                    |
        | het gezag toegewezen aan 'P1' en een derde |              1D | in een gerechtelijke uitspraak is het gezag toegewezen aan '{naam}' en een derde |
        | het gezag toegewezen aan 'P2' en een derde |              2D | in een gerechtelijke uitspraak is het gezag toegewezen aan '{naam}' en een derde |

  Regel: Curatele wordt vastgelegd in de gezagsverhouding

    @integratie
    Scenario: '{naam}' staat onder curatele
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En 'P1' staat onder curatele
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_gezagsverhouding'
        | pl_id | volg_nr | curatele_register_ind |
        | P1    |       0 |                     1 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |

    Scenario: {relatieve datum} heeft '{naam}' het ouderschap ontkend
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En de persoon 'P3' met burgerservicenummer '000000036'
      * is minderjarig
      * heeft 'P1' en 'P2' als ouders
      En 4 jaar geleden heeft 'P1' het ouderschap ontkend
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |                    |               6030 | 1AA0100 |
        | P1    | K            |         0 |       1 |         000000036 | P3             | gisteren - 17 jaar |                    | 1AA0100 |
        | P1    | K            |         0 |       0 |                   |                |                    |                    | 1AE0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |                    |               6030 | 1AA0100 |
        | P2    | K            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |                    | 1AA0100 |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr | familie_betrek_start_datum | geldigheid_start_datum | onjuist_ind |
        | P3    | P            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |               6030 | 1AA0100 |                            |                        |             |
        | P3    |            1 |         0 |       1 |         000000012 | P1             | gisteren - 45 jaar |                    | 1AA0100 | gisteren - 17 jaar         |                        | O           |
        | P3    |            1 |         0 |       0 |                   |                |                    |                    | 1AE0100 |                            |         4 jaar geleden |             |
        | P3    |            2 |         0 |       0 |         000000024 | P2             | gisteren - 45 jaar |                    | 1AA0100 | gisteren - 17 jaar         |                        |             |

    @integratie
    Scenario: '{naam}' heeft ontkend vader te zijn van '{naam}'
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En de persoon 'P3' met burgerservicenummer '000000036'
      * is minderjarig
      * heeft 'P1' en 'P2' als ouders
      En 'P1' heeft ontkend vader te zijn van 'P3'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |                    |               6030 | 1AA0100 |
        | P1    | K            |         0 |       1 |         000000036 | P3             | gisteren - 17 jaar |                    | 1AA0100 |
        | P1    | K            |         0 |       0 |                   |                |                    |                    | 1AE0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |                    |               6030 | 1AA0100 |
        | P2    | K            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |                    | 1AA0100 |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr | familie_betrek_start_datum | geldigheid_start_datum | onjuist_ind |
        | P3    | P            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |               6030 | 1AA0100 |                            |                        |             |
        | P3    |            1 |         0 |       1 |         000000012 | P1             | gisteren - 45 jaar |                    | 1AA0100 | gisteren - 17 jaar         |                        | O           |
        | P3    |            1 |         0 |       0 |                   |                |                    |                    | 1AE0100 |                            | gisteren - 17 jaar     |             |
        | P3    |            2 |         0 |       0 |         000000024 | P2             | gisteren - 45 jaar |                    | 1AA0100 | gisteren - 17 jaar         |                        |             |

    @integratie
    Scenario: heeft '{naam}' als ouder vanaf de geboortedatum
      # deze stap is volledig identiek aan stap "heeft '{naam}' als ouder"
      # toevoeging is alleen bedoeld om aan lezer te benadrukken dat de ouder op de geboorteakte staat en familierechtelijke betrekking gelijk is aan geboortedatum
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000036'
      * heeft 'P1' als ouder vanaf de geboortedatum
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P2             |                    | 1AA0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P2    | P            |         0 |       0 |         000000036 | P2             |               6030 | 1AA0100 |                            |
        | P2    |            1 |         0 |       0 |         000000012 | P1             |                    | 1AA0100 | gisteren - 17 jaar         |

    @integratie
    Scenario: heeft '{naam1}' en '{naam2}' als ouders vanaf de geboortedatum
      # deze stap is volledig identiek aan stap "heeft '{naam1}' en '{naam2}' als ouders"
      # toevoeging is alleen bedoeld om aan lezer te benadrukken dat de ouder op de geboorteakte staat en familierechtelijke betrekking gelijk is aan geboortedatum
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P3' met burgerservicenummer '000000024'
      En de persoon 'P2' met burgerservicenummer '000000036'
      * heeft 'P1' en 'P3' als ouders vanaf de geboortedatum
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P2             |                    | 1AA0100 |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P3    | P            |         0 |       0 |         000000024 | P3             |               6030 | 1AA0100 |
        | P3    | K            |         0 |       0 |         000000036 | P2             |                    | 1AA0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P2    | P            |         0 |       0 |         000000036 | P2             |               6030 | 1AA0100 |                            |
        | P2    |            1 |         0 |       0 |         000000012 | P1             |                    | 1AA0100 | gisteren - 17 jaar         |
        | P2    |            2 |         0 |       0 |         000000024 | P3             |                    | 1AA0100 | gisteren - 17 jaar         |

    @integratie
    Scenario: '{naam}' heeft ontkend vader te zijn van '{naam}'
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En de persoon 'P3' met burgerservicenummer '000000036'
      * is minderjarig
      * heeft 'P1' en 'P2' als ouders
      En 'P1' heeft ontkend vader te zijn van 'P3'
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |                    |               6030 | 1AA0100 |
        | P1    | K            |         0 |       1 |         000000036 | P3             | gisteren - 17 jaar |                    | 1AA0100 |
        | P1    | K            |         0 |       0 |                   |                |                    |                    | 1AE0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |                    |               6030 | 1AA0100 |
        | P2    | K            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |                    | 1AA0100 |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |               6030 | 1AA0100 |                            |
        | P3    |            1 |         0 |       1 |         000000012 | P1             |                    |                    | 1AA0100 | gisteren - 17 jaar         |
        | P3    |            1 |         0 |       0 |                   |                |                    |                    | 1AE0100 |                            |
        | P3    |            2 |         0 |       0 |         000000024 | P2             |                    |                    | 1AA0100 | gisteren - 17 jaar         |

    @integratie
    Scenario: {relatieve datum} heeft '{naam}' het ouderschap ontkend
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En de persoon 'P3' met burgerservicenummer '000000036'
      * is minderjarig
      * heeft 'P1' en 'P2' als ouders
      En 4 jaar geleden heeft 'P1' het ouderschap ontkend
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |                    |               6030 | 1AA0100 |
        | P1    | K            |         0 |       1 |         000000036 | P3             | gisteren - 17 jaar |                    | 1AA0100 |
        | P1    | K            |         0 |       0 |                   |                |                    |                    | 1AE0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |                    |               6030 | 1AA0100 |
        | P2    | K            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |                    | 1AA0100 |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_datum     | geboorte_land_code | akte_nr | familie_betrek_start_datum | geldigheid_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             | gisteren - 17 jaar |               6030 | 1AA0100 |                            |                        |
        | P3    |            1 |         0 |       1 |         000000012 | P1             |                    |                    | 1AA0100 | gisteren - 17 jaar         |                        |
        | P3    |            1 |         0 |       0 |                   |                |                    |                    | 1AE0100 |                            |         4 jaar geleden |
        | P3    |            2 |         0 |       0 |         000000024 | P2             |                    |                    | 1AA0100 | gisteren - 17 jaar         |                        |

    @integratie
    Abstract Scenario: {relatievedatum} is in een gerechtelijke uitspraak het gezag toegewezen aan <gezaghebbende in stapdefinitie>
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En de persoon 'P2' met burgerservicenummer '000000024'
      En de persoon 'P3' met burgerservicenummer '000000036'
      * heeft 'P1' en 'P2' als ouders
      En <relatieve datum> is in een gerechtelijke uitspraak het gezag toegewezen aan <gezaghebbende>
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P1    | P            |         0 |       0 |         000000012 | P1             |               6030 | 1AA0100 |
        | P1    | K            |         0 |       0 |         000000036 | P3             |                    | 1AA0100 |
      En heeft persoon 'P2' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P2    |          0 |
      En heeft persoon 'P2' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr |
        | P2    | P            |         0 |       0 |         000000024 | P2             |               6030 | 1AA0100 |
        | P2    | K            |         0 |       0 |         000000036 | P3             |                    | 1AA0100 |
      En heeft persoon 'P3' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P3    |          0 |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | familie_betrek_start_datum |
        | P3    | P            |         0 |       0 |         000000036 | P3             |               6030 | 1AA0100 |                            |
        | P3    |            1 |         0 |       0 |         000000012 | P1             |                    | 1AA0100 | gisteren - 17 jaar         |
        | P3    |            2 |         0 |       0 |         000000024 | P2             |                    | 1AA0100 | gisteren - 17 jaar         |
      En heeft persoon 'P3' de volgende rijen in tabel 'lo3_pl_gezagsverhouding'
        | pl_id | volg_nr | minderjarig_gezag_ind | geldigheid_start_datum |
        | P3    |       0 | <indicatie gezag>     | <relatieve datum>      |

      Voorbeelden:
        | relatieve datum   | gezaghebbende         | indicatie gezag | gezaghebbende in stapdefinitie |
        |    6 jaar geleden | 'P1'                  |               1 | '{naam}'                       |
        | vorige maand      | 'P2'                  |               2 | '{naam}'                       |
        | gisteren - 5 jaar | een voogdijinstelling | D               | een voogdijinstelling          |
        | gisteren - 4 jaar | een derde             | D               | een derde                      |
        |    2 jaar geleden | beide ouders          |              12 | beide ouders                   |
        |    2 jaar geleden | 'P1' en een derde     |              1D | '{naam}' en een derde          |
        |    2 jaar geleden | 'P2' en een derde     |              2D | '{naam}' en een derde          |
