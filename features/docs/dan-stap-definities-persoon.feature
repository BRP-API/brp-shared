#language: nl

@stap-documentatie
Functionaliteit: Persoon dan stap definities

  Scenario: Dan heeft de response 1 persoon
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [ {} ]
    }
    """
    Dan heeft de response 1 persoon

  Abstract Scenario: Dan heeft de response (nog) een persoon met (alleen) de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "burgerservicenummer": "000000012"
        }
      ]
    }
    """
    Dan <stap definitie met hetzelfde gedrag>
    | naam                | waarde    |
    | burgerservicenummer | 000000012 |

    Voorbeelden:
    | stap definitie met hetzelfde gedrag                               |
    | heeft de response een persoon met de volgende gegevens            |
    | heeft de response een persoon met alleen de volgende gegevens     |
    | heeft de response nog een persoon met de volgende gegevens        |
    | heeft de response nog een persoon met alleen de volgende gegevens |

  Abstract Scenario: Dan heeft de response een persoon met (alleen) de volgende '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "naam": {
            "geslachtsnaam": "Jansen"
          }
        }
      ]
    }
    """
    Dan <stap definitie met hetzelfde gedrag>
    | naam          | waarde |
    | geslachtsnaam | Jansen |

    Voorbeelden:
    | stap definitie met hetzelfde gedrag                                  |
    | heeft de response een persoon met de volgende 'naam' gegevens        |
    | heeft de response een persoon met alleen de volgende 'naam' gegevens |

  Scenario: Dan heeft de response een persoon zonder gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {}
      ]
    }
    """
    Dan heeft de response een persoon zonder gegevens

  Scenario: Dan heeft de response een persoon zonder '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "naam": {}
        }
      ]
    }
    """
    Dan heeft de response een persoon zonder 'naam' gegevens

  Abstract Scenario: Dan heeft de persoon (alleen) de volgende '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "burgerservicenummer": "000000012",
          "geboorte": {
            "datum": "2022-05-06"
          }
        }
      ]
    }
    """
    Dan heeft de response een persoon met de volgende gegevens
    | burgerservicenummer |
    | 000000012           |
    En <stap definitie met hetzelfde gedrag>
    | naam  | waarde     |
    | datum | 2022-05-06 |

    Voorbeelden:
    | stap definitie met hetzelfde gedrag                     |
    | heeft de persoon de volgende 'geboorte' gegevens        |
    | heeft de persoon alleen de volgende 'geboorte' gegevens |

  Scenario: Dan heeft de persoon geen '[gegevensgroep]' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "personen": [
        {
          "naam": {
            "geslachtsnaam": "Jansen"
          },
          "geboorte": {}
        }
      ]
    }
    """
    Dan heeft de response een persoon met de volgende 'naam' gegevens
    | naam          | waarde |
    | geslachtsnaam | Jansen |
    En heeft de persoon geen 'geboorte' gegevens
