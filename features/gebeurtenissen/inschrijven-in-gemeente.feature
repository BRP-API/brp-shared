# language: nl
Functionaliteit: Inschrijven in de BRP

  Achtergrond:
    Gegeven afnemer '000008' wilt worden genotificeerd over 'PersoonIngeschreven' gebeurtenissen
    En adres 'A1' heeft de volgende gegevens
      | gemeentecode | postcode |
      |         0518 |   2500AB |
    En persoon 'Jan' heeft de volgende gegevens
      | geslachtsnaam | voornamen | geboortedatum | geslacht |
      | Janssen       | Jan       |    1980-01-01 | M        |
    En 'Jan' verblijft vanaf '2025-07-01' op adres 'A1'
    Als 'Jan' wordt ingeschreven in de BRP

  Regel: Na het succesvol verwerken van een inschrijving bevat de response de burgerservicenummer van de ingeschreven persoon

    Scenario: inschrijving van een persoon
      Dan is een burgerservicenummer toegekend aan 'Jan'

  Regel: Na het succesvol verwerken van de inschrijving is een rij toegevoegd aan de lo3_pl, lo3_pl_persoon en de lo3_pl_verblijfplaats tabellen

    Scenario: inschrijving van een persoon
      Dan heeft 'Jan' de volgende rij in tabel 'lo3_pl'
        | pl_id | geheim_ind |
        | Jan   |          0 |
      En heeft 'Jan' de volgende rij in tabel 'lo3_pl_persoon'
        | pl_id | stapel_nr | volg_nr | persoon_type | burger_service_nr | geslachts_naam | voor_naam | geboorte_datum | geslachts_aand |
        | Jan   |         0 |       0 | P            |         000000012 | Janssen        | Jan       |       19800101 | M              |
      En heeft 'Jan' de volgende rij in tabel 'lo3_pl_verblijfplaats'
        | pl_id | adres_id | volg_nr | adres_functie | inschrijving_gemeente_code | adreshouding_start_datum |
        | Jan   | A1       |       0 | W             |                       0518 |                 20250701 |

  Regel: Na het succesvol verwerken van een inschrijving is een 'PersoonIngeschreven' gebeurtenis gepubliceerd

    Scenario: inschrijving van een persoon
      Dan is een 'PersoonIngeschreven' gebeurtenis voor 'Jan' gepubliceerd

  Regel: Na het publiceren van een 'PersoonIngeschreven' gebeurtenis worden de subscribers van 'PersoonIngeschreven' gebeurtenissen genotificeerd

    Scenario: inschrijving van een persoon
      Dan is afnemer '000008' genotificeerd over de 'PersoonIngeschreven' gebeurtenis voor 'Jan'