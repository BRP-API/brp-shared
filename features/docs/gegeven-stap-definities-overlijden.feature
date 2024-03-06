#language: nl

@stap-documentatie
Functionaliteit: Overlijden gegeven stap definities

  Achtergrond:
    Gegeven de 1e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '9999'
    En de 2e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '10000'

  Scenario: de persoon met burgerservicenummer '[bsn]' heeft de volgende gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    En de persoon heeft de volgende 'overlijden' gegevens
    | datum overlijden (08.10) |
    | 20020701                 |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie    | text                                                                                                                                                  | values                      |
    | 1    | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                           |
    |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr,geslachts_naam) VALUES($1,$2,$3,$4,$5,$6)                    | 9999,0,0,P,000000012,Jansen |
    |      | overlijden   | INSERT INTO public.lo3_pl_overlijden(pl_id,volg_nr,overlijden_datum) VALUES($1,$2,$3)                                                                 | 9999,0,20020701             |