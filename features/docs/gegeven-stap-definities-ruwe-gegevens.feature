# language: nl
@stap-documentatie
Functionaliteit: gegevens opgeven met waardentabel

  Regel: heeft {object soort} met de volgende gegevens

    @integratie
    Abstract Scenario: heeft <relatie> met de volgende gegevens
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * heeft <relatie> met de volgende gegevens
        | naam                        | waarde    |
        | burgerservicenummer (01.20) | 000000024 |
        | voornamen (02.10)           | Helena    |
        | geslachtsnaam (02.40)       | Hanssen   |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type   | stapel_nr | volg_nr | burger_service_nr | voor_naam | geslachts_naam |
        | P1    | P              |         0 |       0 |         000000012 |           | P1             |
        | p1    | <persoon type> |         0 |       0 |         000000024 | Helena    | Hanssen        |

      Voorbeelden:
        | relatie     | persoon type |
        | een ouder 1 |            1 |
        | een ouder 2 |            2 |
        | een parner  | R            |
        | een kind    | K            |

    @integratie
    Abstract Scenario: meerdere van zelfde object soort: heeft <relatie> met de volgende gegevens
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * heeft <relatie> met de volgende gegevens
        | naam                        | waarde    |
        | burgerservicenummer (01.20) | 000000024 |
        | voornamen (02.10)           | Helena    |
        | geslachtsnaam (02.40)       | Hanssen   |
      * heeft <relatie> met de volgende gegevens
        | naam                  | waarde  |
        | voornamen (02.10)     | Herman  |
        | geslachtsnaam (02.40) | Hanssen |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type   | stapel_nr | volg_nr | burger_service_nr | voor_naam | geslachts_naam |
        | P1    | P              |         0 |       0 |         000000012 |           | P1             |
        | P1    | <persoon type> |         0 |       0 |         000000024 | Helena    | Hanssen        |
        | P1    | <persoon type> |         1 |       0 |                   | Herman    | Hanssen        |

      Voorbeelden:
        | relatie    | persoon type |
        | een parner | R            |
        | een kind   | K            |

    @integratie
    Abstract Scenario: meerdere van verschillende object soort: heeft <relatie> met de volgende gegevens
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * heeft een ouder 1 met de volgende gegevens
        | naam                        | waarde    |
        | burgerservicenummer (01.20) | 000000024 |
        | voornamen (02.10)           | Helena    |
        | geslachtsnaam (02.40)       | Hanssen   |
      * heeft een partner met de volgende gegevens
        | naam                        | waarde    |
        | burgerservicenummer (01.20) | 000000036 |
        | voornamen (02.10)           | Herman    |
        | geslachtsnaam (02.40)       | Hapert    |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | voor_naam | geslachts_naam |
        | P1    | P            |         0 |       0 |         000000012 |           | P1             |
        | P1    |            1 |         0 |       0 |         000000024 | Helena    | Hanssen        |
        | P1    | R            |         0 |       0 |         000000036 | Herman    | Hapert         |

  Regel: {object soort} is {gewijzigd of gecorrigeerd} naar de volgende gegevens

    @integratie
    Abstract Scenario: <object soort wijziging> is <soort wijziging> naar de volgende gegevens
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * heeft <object soort toevoeging> met de volgende gegevens
        | naam                  | waarde  |
        | voornamen (02.10)     | Helena  |
        | geslachtsnaam (02.40) | Hanssen |
      En <object soort wijziging> is <soort wijziging> naar de volgende gegevens
        | naam                        | waarde    |
        | burgerservicenummer (01.20) | 000000024 |
        | voornamen (02.10)           | Herman    |
        | geslachtsnaam (02.40)       | Hanssen   |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | P1    |          0 |
      En heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_persoon'
        | pl_id | persoon_type   | stapel_nr | volg_nr | burger_service_nr | voor_naam | geslachts_naam | onjuist_ind |
        | P1    | P              |         0 |       0 |         000000012 |           | P1             |             |
        | P1    | <persoon type> |         0 |       1 |                   | Helena    | Hanssen        | <onjuist>   |
        | P1    | <persoon type> |         0 |       0 |         000000024 | Herman    | Hanssen        |             |

      Voorbeelden:
        | object soort toevoeging | object soort wijziging | persoon type | soort wijziging | onjuist |
        | een ouder 1             | ouder 1                |            1 | gewijzigd       |         |
        | een ouder 2             | ouder 2                |            2 | gecorrigeerd    | O       |
        | een parner              | de partner             | R            | gewijzigd       |         |
        | een kind                | het kind               | K            | gecorrigeerd    | O       |

  Regel: is ingeschreven op adres {string} met de volgende gegevens

    @integratie
    Scenario: is ingeschreven op adres {string} met de volgende gegevens
      Gegeven adres 'A1'
        | gemeentecode (92.10) | straatnaam (11.10) |
        |                 0518 | Boterdiep          |
      En de persoon 'P1' met burgerservicenummer '000000012'
      En is ingeschreven op adres 'A1' met de volgende gegevens
        | naam                               | waarde   |
        | functie adres (10.10)              | B        |
        | datum aanvang adreshouding (10.30) | 20111101 |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_verblijfplaats'
        | pl_id | adres_id | volg_nr | adres_functie | adreshouding_start_datum |
        | P1    | A1       |       0 | B             |                 20111101 |

  Regel: is ingeschreven op een buitenlands adres met de volgende gegevens

    @integratie
    Scenario: is ingeschreven op een buitenlands adres met de volgende gegevens
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      En is ingeschreven op een buitenlands adres met de volgende gegevens
        | naam                                   | waarde   |
        | land (13.10)                           |     6039 |
        | datum aanvang adres buitenland (13.20) | 20111101 |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_verblijfplaats'
        | pl_id | adres_id | volg_nr | vertrek_land_code | vertrek_datum |
        | P1    |          |       0 |              6039 |      20111101 |

  Regel: is overleden met de volgende gegevens

    @integratie
    Scenario: is overleden met de volgende gegevens
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * is overleden met de volgende gegevens
        | naam                      | waarde   |
        | datum overlijden (08.10)  | 20230924 |
        | plaats overlijden (08.20) |     0518 |
        | land overlijden (08.30)   |     6030 |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rijen in tabel 'lo3_pl_overlijden'
        | pl_id | volg_nr | overlijden_datum | overlijden_plaats | overlijden_land_code |
        | P1    |       0 |         20230924 |              0518 |                 6030 |

  Regel: is ingeschreven met de volgende gegevens

    @integratie
    Scenario: is ingeschreven met de volgende gegevens
      Gegeven de persoon 'P1' met burgerservicenummer '000000012'
      * is ingeschreven met de volgende gegevens
        | naam                                 | waarde   |
        | datum opschorting bijhouding (67.10) | 20181201 |
        | reden opschorting bijhouding (67.20) | E        |
        | indicatie geheim (70.10)             |        7 |
      Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
      Dan heeft persoon 'P1' de volgende rij in tabel 'lo3_pl'
        | pl_id | bijhouding_opschort_datum | bijhouding_opschort_reden | geheim_ind |
        | P1    |                  20181201 | E                         |          7 |
