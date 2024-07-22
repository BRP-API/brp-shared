// 01: Inschrijving Persoon => lo3_pl
    16620, // datum ingang blokkering => pl_blokkering_start_datum
    16710, // datum opschorting bijhouding => bijhouding_opschort_datum
    16720, // reden opschorting bijhouding => bijhouding_opschort_reden
    16810, // datum eerste inschrijving GBA => gba_eerste_inschrijving_datum
    17010, // indicatie geheim => geheim_ind
    17110, // datum verificatie => verificatie_datum
    17210, // omschrijving verificatie => verificatie_oms

// 01: Persoon => lo3_pl_persoon (stapel_nr=0, volg_nr=0, persoon_type=P)
    10110, // anummer => a_nr
    10120, // burgerservicenummer => burger_service_nr
    10210, // voornamen => voor_naam
         , // voornamen (diakrieten) => diak_voor_naam
    10220, // adellijke titel of predicaat => titel_predicaat
    10230, // voorvoegsel geslachtsnaam => geslachts_naam_voorvoegsel
    10240, // geslachtsnaam => geslachts_naam
         , // geslachtsnaam (diakrieten) => diak_geslachts_naam
    10310, // geboortedatum => geboorte_datum
    10320, // geboorteplaats => geboorte_plaats
    10330, // geboorteland => geboorte_land_code
    10410, // geslachtsaanduiding => geslachts_aand
    18120, // aktenummer => akte_nr
    18230, // beschrijving document => doc_beschrijving

// 51: Persoon Geschiedenis  (stapel_nr=0, volg_nr=1++, persoon_type=P)
    518120, // aktenummer => akte_nr
    518230, // beschrijving document => doc_beschrijving

// 02: Ouder 1 => lo3_pl_persoon (stapel_nr=0, volg_nr=0, persoon_type=1)
    20120, // burgerservicenummer
    20210, // voornamen
    20240, // geslachtsnaam
    26210, // datum ingang familierechtelijke betrekking => familie_betrek_start_datum
    28120, // aktenummer

// 52: Ouder 1 Geschiedenis (Adoptieouder 1)
    520210, // voornamen
    520240, // geslachtsnaam
    526210, // datum ingang familierechtelijke betrekking
    528120, // aktenummer

// 03: Ouder 2 => lo3_pl_persoon (stapel_nr=0, volg_nr=0, persoon_type=2)
    30120, // burgerservicenummer
    30210, // voornamen
    30240, // geslachtsnaam
    36210, // datum ingang familierechtelijke betrekking
    38120, // aktenummer

// 53: Ouder 2 Geschiedenis (Adoptieouder 2)
    530210, // voornamen
    530240, // geslachtsnaam
    536210, // datum ingang familierechtelijke betrekking
    538120, // aktenummer

// 05: Huwelijk/geregistreerd partnerschap (HuwelijkOfPartnerschap) => lo3_pl_persoon (stapel_nr=0, volg_nr=0, persoon_type=R)
    50120, // burgerservicenummer
    50610, // datum huwelijkssluiting/aangaan geregistreerd partnerschap => relatie_start_datum
    50620, // plaats huwelijkssluiting/aangaan geregistreerd partnerschap => relatie_start_plaats
    50630, // land huwelijkssluiting/aangaan geregistreerd partnerschap => relatie_start_land_code
    50710, // datum ontbinding huwelijk/geregistreerd partnerschap => relatie_eind_datum
    50720, // plaats ontbinding huwelijk/geregistreerd partnerschap = relatie_eind_plaats
    50730, // land ontbinding huwelijk/geregistreerd partnerschap => relatie_eind_land_code
    50740, // reden ontbinding huwelijk/geregistreerd partnerschap => relatie_eind_reden

// 55: Huwelijk/geregistreerd partnerschap (HuwelijkOfPartnerschap Geschiedenis) => lo3_pl_persoon (stapel_nr=0, volg_nr=1++, persoon_type=R)
    550610, //
    550620, //
    550630, //
    550710, //
    550720, //
    550730, //
    550740, //

// 05: Huwelijk/geregistreerd partnerschap volgende partner  => lo3_pl_persoon (stapel_nr=1++, volg_nr=0, persoon_type=R)

// 09: Kind => lo3_pl_persoon (stapel_nr=0, volg_nr=0, persoon_type=K)

// 09: volgende Kind => lo3_pl_persoon (stapel_nr=1++, volg_nr=0, persoon_type=K)


inschrijving van persoon in registratie
- nieuwe rij in lo3_pl
- nieuwe rij in lo3_pl_persoon met default waarden: stapel_nr=0, volg_nr=0, persoon_type=P

gegevens wijzigen van persoon
- volg_nr van alle rijen van de betreffende persoon wordt opgehoogd met 1
- nieuwe rij in lo3_pl_persoon met default waarden: stapel_nr=0, volg_nr=0, persoon_type=P

gegevens corrigeren van persoon
- volg_nr van alle rijen van de betreffende persoon wordt opgehoogd met 1
- zet column onjuist_ind = O voor rij met volg_nr=1
- nieuwe rij in lo3_pl_persoon met default waarden: stapel_nr=0, volg_nr=0, persoon_type=P

registratie van ouder 1
- nieuwe rij in lo3_pl_persoon met pl_id=pl_id van persoon en default waarden: stapel_nr=0, volg_nr=0, persoon_type=1

registratie van een ouder 2
- nieuwe rij in lo3_pl_persoon met pl_id=pl_id van persoon en default waarden: stapel_nr=0, volg_nr=0, persoon_type=2

registratie van een partner
- nieuwe rij in lo3_pl_persoon met pl_id=pl_id van persoon en default waarden: stapel_nr=0, volg_nr=0, persoon_type=R

registratie van een volgende partner
- nieuwe rij in lo3_pl_persoon met pl_id=pl_id van persoon en default waarden: stapel_nr=aantal partners van persoon+1, volg_nr=0, persoon_type=R

registratie van een kind
- nieuwe rij in lo3_pl_persoon met pl_id=pl_id van persoon en default waarden: stapel_nr=0, volg_nr=0, persoon_type=K

registratie van een volgende kind
- nieuwe rij in lo3_pl_persoon met pl_id=pl_id van persoon en default waarden: stapel_nr=aantal kinderen van persoon+1, volg_nr=0, persoon_type=K
