  #language: nl

@integratie @stap-documentatie
Functionaliteit: Persoon stap definities

  Scenario: de persoon met burgerservicenummer '[bsn]'
    Gegeven de persoon 'Gerda' met burgerservicenummer '000000012'
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Gerda' de volgende rij in tabel 'lo3_pl'
    | pl_id | geheim_ind |
    | 1     | 0          |
    En heeft de persoon 'Gerda' de volgende rij in tabel 'lo3_pl_persoon'
    | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam |
    | 1     | P            | 0         | 0       | 000000012         | Gerda          |

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
    | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam |
    | 1     | P            | 0         | 0       | 000000012         | Gerda          |
    En heeft de persoon 'Gerda' de volgende rij in tabel 'lo3_pl_verblijfplaats'
    | pl_id | volg_nr | inschrijving_gemeente_code |
    | 1     | 0       | 0518                       |

  Abstract Scenario: is ingeschreven in de RNI
    Gegeven de persoon 'Gerda' met burgerservicenummer '000000012'
    En <gegeven stap>
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Gerda' de volgende rij in tabel 'lo3_pl'
    | pl_id | geheim_ind |
    | 1     | 0          |
    En heeft de persoon 'Gerda' de volgende rij in tabel 'lo3_pl_persoon'
    | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam |
    | 1     | P            | 0         | 0       | 000000012         | Gerda          |
    En heeft de persoon 'Gerda' de volgende rij in tabel 'lo3_pl_verblijfplaats'
    | pl_id | volg_nr | inschrijving_gemeente_code |
    | 1     | 0       | 1999                       |

    Voorbeelden:
    | gegeven stap                      |
    | is ingeschreven in de RNI         |
    | 'Gerda' is ingeschreven in de RNI |

  Abstract Scenario: <scenario>
    Gegeven de persoon 'Gerda' met burgerservicenummer '000000012'
    * is ingeschreven in de <vorige inschrijving>
    * is vervolgens ingeschreven in de <huidige inschrijving>
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Gerda' de volgende rij in tabel 'lo3_pl'
    | pl_id | geheim_ind |
    | 1     | 0          |
    En heeft de persoon 'Gerda' de volgende rij in tabel 'lo3_pl_persoon'
    | pl_id | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam |
    | 1     | P            | 0         | 0       | 000000012         | Gerda          |
    En heeft de persoon 'Gerda' de volgende rij in tabel 'lo3_pl_verblijfplaats'
    | pl_id | volg_nr | inschrijving_gemeente_code           |
    | 1     | 1       | <vorige inschrijving gemeente code>  |
    | 1     | 0       | <huidige inschrijving gemeente code> |

    Voorbeelden:
    | scenario                                                                             | vorige inschrijving | huidige inschrijving | vorige inschrijving gemeente code | huidige inschrijving gemeente code |
    | staat ingeschreven in RNI en stond daarvoor ingeschreven in een Nederlandse gemeente | BRP                 | RNI                  | 0518                              | 1999                               |
    | staat ingeschreven in Nederlandse gemeente en stond daarvoor ingeschreven in het RNI | RNI                 | BRP                  | 1999                              | 0518                               |
