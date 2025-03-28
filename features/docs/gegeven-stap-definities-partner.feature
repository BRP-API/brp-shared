# language: nl
@stap-documentatie
Functionaliteit: Partner gegeven stap definities

  Achtergrond:
    Gegeven de 1e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '9999'

  Scenario: de persoon met burgerservicenummer '[bsn]' heeft een 'partner' met de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
    Dan zijn de gegenereerde SQL statements
      | stap | categorie    | text                                                                                                                                                  | values               |
      |    1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                    0 |
      |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
      |      | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         |    9999,0,0,R,Jansen |

  Scenario: de persoon heeft (nog) een 'partner' met de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
    En de persoon heeft nog een 'partner' met de volgende gegevens
      | geslachtsnaam (02.40) |
      | Aedel                 |
    Dan zijn de gegenereerde SQL statements
      | stap | categorie    | text                                                                                                                                                  | values               |
      |    1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                    0 |
      |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
      |      | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         |    9999,0,0,R,Jansen |
      |      | partner-2    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         |     9999,1,0,R,Aedel |

  Scenario: de 'partner' is gewijzigd naar de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
    En de 'partner' is gewijzigd naar de volgende gegevens
      | geslachtsnaam (02.40) |
      | Aedel                 |
    Dan zijn de gegenereerde SQL statements
      | stap | categorie    | text                                                                                                                                                  | values               |
      |    1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                    0 |
      |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
      |      | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         |    9999,0,1,R,Jansen |
      |      |              | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         |     9999,0,0,R,Aedel |

  Scenario: de 'partner' is gecorrigeerd naar de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | Jansen |
    En de 'partner' is gecorrigeerd naar de volgende gegevens
      | geslachtsnaam (02.40) |
      | Aedel                 |
    Dan zijn de gegenereerde SQL statements
      | stap | categorie    | text                                                                                                                                                  | values               |
      |    1 | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * |                    0 |
      |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
      |      | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam,onjuist_ind) VALUES($1,$2,$3,$4,$5,$6)                          |  9999,0,1,R,Jansen,O |
      |      |              | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         |     9999,0,0,R,Aedel |

  @integratie
  Scenario: '{naam1}' en '{naam2}' zijn {relatieve datum} een geregistreerd partnerschap aangegaan
    Gegeven de persoon 'Arjan' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000012 | Arjan                 |
    Gegeven de persoon 'Tosca' heeft de volgende gegevens
      | burgerservicenummer (01.20) | geslachtsnaam (02.40) |
      |                   000000024 | Tosca                 |
    En 'Arjan' en 'Tosca' zijn 7 jaar geleden een geregistreerd partnerschap aangegaan
    Als de sql statements gegenereerd uit de gegeven stappen zijn uitgevoerd
    Dan heeft de persoon 'Arjan' de volgende rijen in tabel 'lo3_pl_persoon'
      | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
      | R            |         0 |       0 |         000000024 | Tosca          |                    |         |      7 jaar geleden |                 0518 |                    6030 | P                 |
    En heeft de persoon 'Tosca' de volgende rijen in tabel 'lo3_pl_persoon'
      | persoon_type | stapel_nr | volg_nr | burger_service_nr | geslachts_naam | geboorte_land_code | akte_nr | relatie_start_datum | relatie_start_plaats | relatie_start_land_code | verbintenis_soort |
      | R            |         0 |       0 |         000000012 | Arjan          |                    |         |      7 jaar geleden |                 0518 |                    6030 | P                 |
