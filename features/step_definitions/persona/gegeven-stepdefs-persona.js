const { Given } = require('@cucumber/cucumber');
const { arrayOfArraysToDataTable } = require('../dataTableFactory');
const { aanvullenInschrijving } = require('../persoon-2');
const { getPersoon } = require('../contextHelpers');
const { gegevenDePersoon } = require('../expressief/gegeven-stepdefs-persoon');
const { gegevenDePersoonIsGeborenOp } = require('../gegeven-stepdefs-geboorte');
const { gegevenDePersoonIsIngeschrevenInGemeente,
        gegevenDePersoonIsIngeschrevenInDeBrp } = require('../expressief/gegeven-stepdefs-verblijfplaats');
const { gegevenDePersoonHeeftAlsOuder, gegevenDePersoonHeeftAlsOuders } = require('../expressief/gegeven-stepdefs-ouder');
const { gegevenDePersonenZijnGehuwd } = require('../expressief/gegeven-stepdefs-partner');

// **************************************************************************************************************
//                     functies "geleend" uit expressief/gegeven-stepdefs-context.js
// **************************************************************************************************************

function wijzigPersoonContext(context, aanduiding) {
  const persoonId = `persoon-${aanduiding}`;
  const index = context.data.personen.findIndex(element => element.id === persoonId);

  if (index !== -1) {
      const [element] = context.data.personen.splice(index, 1);
      context.data.personen.push(element);
  }
}

// **************************************************************************************************************
//                     default gevulde personen als startpunt van een scenario
// **************************************************************************************************************

const ouder1Burgerservicenummer        = '000000101'
const ouder2Burgerservicenummer        = '000000102'
const persoonBurgerservicenummer       = '000000103'
const adoptieOuder1Burgerservicenummer = '000000104'
const adoptieOuder2Burgerservicenummer = '000000105'
const partnerBurgerservicenummer       = '000000106'

const geboortedatumMinderjarige  = 'gisteren - 16 jaar'
const geboortedatumMeerderjarige = 'morgen - 37 jaar'

const defaultLandCode = '6030';

function createPersoonData(geslachtsnaam, geboorteland = defaultLandCode, burgerservicenummer = persoonBurgerservicenummer, geboortedatum = geboortedatumMinderjarige) {
  return [
    ['burgerservicenummer (01.20)', burgerservicenummer],
    ['geslachtsnaam (02.40)', geslachtsnaam],
    ['geboortedatum (03.10)', geboortedatum],
    ['geboorteland (03.30)', geboorteland]
  ];
}

const geboorteaktePersoon = [
  ['aktenummer (81.20)', '1XA3600']
];

const geboorteakteMoeder = [
  ['aktenummer (81.20)', '1XA1200']
];

const geboorteakteVader = [
  ['aktenummer (81.20)', '1XA2400']
];

function createOuderData(burgerservicenummer, geslachtsnaam, geboortedatum, geslachtsaanduiding) {
  return [
    ['burgerservicenummer (01.20)', burgerservicenummer],
    ['geslachtsnaam (02.40)', geslachtsnaam],
    ['geboortedatum (03.10)', geboortedatum],
    ['geslachtsaanduiding (04.10)', geslachtsaanduiding]
  ];
}

function gegevenDeMeerderjarige(context, aanduiding, meerderjarigeData) {
  gegevenDePersoon(context, aanduiding, arrayOfArraysToDataTable(meerderjarigeData));
  gegevenDePersoonIsGeborenOp(context, aanduiding, geboortedatumMeerderjarige);
}

function gegevenDePersonenZijnInNederlandGehuwd(context, aanduiding1, aanduiding2) {
  const huwelijkData = [
    ['datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)', 'gisteren - 20 jaar'],
    ['plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)', '0518'],
    ['land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)', '6030'],
    ['soort verbintenis (15.10)', 'H'],
    ['aktenummer (81.20)', '3XA1224']
  ]
  gegevenDePersonenZijnGehuwd(context, aanduiding1, aanduiding2, arrayOfArraysToDataTable(huwelijkData));
}

function gegevenDeMinderjarige(context, aanduiding, persoonData, verblijfplaatsData) {
  gegevenDePersoon(context, aanduiding, arrayOfArraysToDataTable(persoonData));

  if(!verblijfplaatsData) {
    gegevenDePersoonIsIngeschrevenInDeBrp(context, aanduiding);
  } else {
    gegevenDePersoonIsIngeschrevenInGemeente(context, aanduiding, arrayOfArraysToDataTable(verblijfplaatsData));
  }
}

function gegevenDeInNederlandGeborenMinderjarige(context, aanduiding, persoonData) {
  const geboorteaktePersoon = [
    ['aktenummer (81.20)', '1XA3600']
  ];

  gegevenDeMinderjarige(context, aanduiding, persoonData.concat(geboorteaktePersoon));
}

function gegevenDeInBuitenlandGeborenMinderjarige(context, aanduiding, persoonData) {
  const verblijfplaatsData = [
    ['gemeente van inschrijving (09.10)', '0518'],
    ['land vanwaar ingeschreven (14.10)', '6029'],
    ['datum vestiging in Nederland (14.20)', 'gisteren - 5 jaar'],
  ];

  gegevenDeMinderjarige(context, aanduiding, persoonData, verblijfplaatsData);
}

function gegevenDeMinderjarigeHeeftAlsOuders(context, aanduidingMinderjarige, aanduidingOuder1, ouder1Data, ouder1KindData, aanduidingOuder2, ouder2Data, ouder2KindData) {
  gegevenDePersoonHeeftAlsOuder(context, aanduidingMinderjarige, aanduidingOuder1, '1',
    ouder1Data ? arrayOfArraysToDataTable(ouder1Data) : undefined,
    ouder1KindData ? arrayOfArraysToDataTable(ouder1KindData) : undefined
  );
  gegevenDePersoonHeeftAlsOuder(context, aanduidingMinderjarige, aanduidingOuder2, '2',
    ouder2Data ? arrayOfArraysToDataTable(ouder2Data) : undefined,
    ouder2KindData ? arrayOfArraysToDataTable(ouder2KindData) : undefined
  );
}

function gegevenDeInBuitenlandGeborenMinderjarigeHeeftEenOuder(context, aanduidingMinderjarige, aanduidingOuder, ouderData, ouderKindData) {
  const legeOuderData = [
    ['beschrijving document (82.30)', 'buitenlandse geboorteakte'],
    ['datum ingang geldigheid (85.10)', geboortedatumMinderjarige]
  ]

  gegevenDeMinderjarigeHeeftAlsOuders(context, aanduidingMinderjarige,
    aanduidingOuder, ouderData, ouderKindData,
    undefined, legeOuderData, undefined
  );
}

// dit is een in Nederland geboren minderjarige met een moeder en een vader die nooit met elkaar gehuwd waren
Given('de minderjarige persoon {string} met twee ouders {string} en {string} die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren', function (aanduidingPersoon, aanduidingOuder1, aanduidingOuder2) {

  const persoonData = createPersoonData(aanduidingPersoon);

  const erkenningAkte = [
    ['aktenummer (81.20)', '1XB3624']
  ];

  const moederData = createOuderData(ouder1Burgerservicenummer, aanduidingOuder1, geboortedatumMeerderjarige, 'V');

  const vaderData = createOuderData(ouder2Burgerservicenummer, aanduidingOuder2, geboortedatumMeerderjarige, 'M');

  const ouderData = [
    ['datum ingang familierechtelijke betrekking (62.10)', geboortedatumMinderjarige]
  ];

  gegevenDeMeerderjarige(this.context, aanduidingOuder1, moederData.concat(geboorteakteMoeder));
  gegevenDeMeerderjarige(this.context, aanduidingOuder2, vaderData.concat(geboorteakteVader));

  gegevenDeInNederlandGeborenMinderjarige(this.context, aanduidingPersoon, persoonData);
  gegevenDeMinderjarigeHeeftAlsOuders(this.context, aanduidingPersoon,
    aanduidingOuder1, ouderData.concat(geboorteaktePersoon), geboorteaktePersoon,
    aanduidingOuder2, ouderData.concat(erkenningAkte), erkenningAkte
  );

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});

// dit is een in Nederland geboren minderjarige met een moeder en een vader die met elkaar gehuwd zijn
Given('de minderjarige persoon {string} met twee gehuwde ouders {string} en {string}', function (aanduidingPersoon, aanduidingOuder1, aanduidingOuder2) {

  const persoonData = createPersoonData(aanduidingPersoon);

  const moederData = createOuderData(ouder1Burgerservicenummer, aanduidingOuder1, geboortedatumMeerderjarige, 'V');

  const vaderData = createOuderData(ouder2Burgerservicenummer, aanduidingOuder2, geboortedatumMeerderjarige, 'M');

  gegevenDeMeerderjarige(this.context, aanduidingOuder1, moederData.concat(geboorteakteMoeder));
  gegevenDeMeerderjarige(this.context, aanduidingOuder2, vaderData.concat(geboorteakteVader));
  gegevenDePersonenZijnInNederlandGehuwd(this.context, aanduidingOuder1, aanduidingOuder2);

  gegevenDeInNederlandGeborenMinderjarige(this.context, aanduidingPersoon, persoonData);
  gegevenDePersoonHeeftAlsOuders(this.context, aanduidingPersoon, aanduidingOuder1, aanduidingOuder2);

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});

// dit is een in Nederland geboren minderjarige met een moeder die ongehuwd is en geen tweede ouder
Given('de minderjarige persoon {string} met één ouder {string}', function(aanduidingPersoon, aanduidingOuder1) {
  const persoonData = createPersoonData(aanduidingPersoon);

  const moederData = createOuderData(ouder1Burgerservicenummer, aanduidingOuder1, geboortedatumMeerderjarige, 'V');

  gegevenDeMeerderjarige(this.context, aanduidingOuder1, moederData.concat(geboorteakteMoeder));

  gegevenDeInNederlandGeborenMinderjarige(this.context, aanduidingPersoon, persoonData);
  gegevenDePersoonHeeftAlsOuders(this.context, aanduidingPersoon, aanduidingOuder1, undefined);

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});

// dit is een in Nederland geboren minderjarige met een moeder die gehuwd is en er is geen tweede ouder
Given('de minderjarige persoon {string} met één ouder {string} die gehuwd is met {string}', function(aanduidingPersoon, aanduidingOuder1, aanduidingPartner) {

  const persoonData = createPersoonData(aanduidingPersoon);

  const moederData = createOuderData(ouder1Burgerservicenummer, aanduidingOuder1, geboortedatumMeerderjarige, 'V');

  const partnerData = createOuderData(ouder2Burgerservicenummer, aanduidingPartner, geboortedatumMeerderjarige, 'V');

  const geboorteaktePartner = [
    ['aktenummer (81.20)', '1XA2400']
  ];

  gegevenDeMeerderjarige(this.context, aanduidingOuder1, moederData.concat(geboorteakteMoeder));
  gegevenDeMeerderjarige(this.context, aanduidingPartner, partnerData.concat(geboorteaktePartner));
  gegevenDePersonenZijnInNederlandGehuwd(this.context, aanduidingOuder1, aanduidingPartner);

  gegevenDeInNederlandGeborenMinderjarige(this.context, aanduidingPersoon, persoonData);
  gegevenDePersoonHeeftAlsOuders(this.context, aanduidingPersoon, aanduidingOuder1, undefined);

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});

// dit is een in het buitenland geboren minderjarige met een moeder en een vader die met elkaar gehuwd zijn en het hele gezin is geïmmigreerd naar Nederland
Given('de minderjarige persoon {string} geboren in het buitenland met twee gehuwde ouders {string} en {string}', function (aanduidingPersoon, aanduidingOuder1, aanduidingOuder2) {
  const geboorteaktePersoon = [
    ['beschrijving document (82.30)', 'buitenlandse geboorteakte']
  ];

  const persoonData = createPersoonData(aanduidingPersoon, '6029').concat(geboorteaktePersoon);

  const moederData = createOuderData(ouder1Burgerservicenummer, aanduidingOuder1, geboortedatumMeerderjarige, 'V');

  const geboorteakteMoeder = [
    ['beschrijving document (82.30)', 'paspoort']
  ];

  const vaderData = createOuderData(ouder2Burgerservicenummer, aanduidingOuder2, geboortedatumMeerderjarige, 'M');

  const geboorteakteVader = [
    ['beschrijving document (82.30)', 'beëdigde verklaring']
  ];

  const huwelijkData = [
    ['datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)', 'gisteren - 20 jaar'],
    ['plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)', 'Teststadt'],
    ['land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)', '6029'],
    ['soort verbintenis (15.10)', 'H'],
    ['beschrijving document (82.30)', 'buitenlandse huwelijkseakte']
  ]

  gegevenDeMeerderjarige(this.context, aanduidingOuder1, moederData.concat(geboorteakteMoeder));
  gegevenDeMeerderjarige(this.context, aanduidingOuder2, vaderData.concat(geboorteakteVader));
  gegevenDePersonenZijnGehuwd(this.context, aanduidingOuder1, aanduidingOuder2, arrayOfArraysToDataTable(huwelijkData));

  gegevenDeInBuitenlandGeborenMinderjarige(this.context, aanduidingPersoon, persoonData);
  gegevenDePersoonHeeftAlsOuders(this.context, aanduidingPersoon, aanduidingOuder1, aanduidingOuder2);

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});

// dit is een in het buitenland geboren minderjarige met een moeder en minderjarige en moeder zijn geïmmigreerd naar Nederland
Given('de minderjarige persoon {string} geboren in het buitenland met één ouder {string}', function (aanduidingPersoon, aanduidingOuder1) {
  const geboorteaktePersoon = [
    ['beschrijving document (82.30)', 'buitenlandse geboorteakte']
  ];

  const persoonData = createPersoonData(aanduidingPersoon, '6029').concat(geboorteaktePersoon);

  const moederData = createOuderData(ouder1Burgerservicenummer, aanduidingOuder1, geboortedatumMeerderjarige, 'V');

  const geboorteakteMoeder = [
    ['beschrijving document (82.30)', 'paspoort']
  ];

  gegevenDeMeerderjarige(this.context, aanduidingOuder1, moederData.concat(geboorteakteMoeder));

  gegevenDeInBuitenlandGeborenMinderjarige(this.context, aanduidingPersoon, persoonData);
  gegevenDePersoonHeeftAlsOuders(this.context, aanduidingPersoon, aanduidingOuder1, undefined);

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});

// dit is een in het buitenland geboren minderjarige die is geadopteerd door één ouder
Given('de minderjarige persoon {string} geboren in het buitenland geadopteerd door één ouder {string}', function (aanduidingPersoon, aanduidingAdoptieouder) {
  const adoptiedatum = 'gisteren - 15 jaar'

  const adoptieaktePersoon = [
    ['aktenummer (81.20)', '1XQ2436']
  ];

  const persoonData = createPersoonData(aanduidingPersoon, '6029').concat(adoptieaktePersoon);

  const moederData = createOuderData(adoptieOuder1Burgerservicenummer, aanduidingAdoptieouder, geboortedatumMeerderjarige, 'V');

  const geboorteakteMoeder = [
    ['beschrijving document (82.30)', 'paspoort']
  ];

  const ouderData = [
    ['datum ingang familierechtelijke betrekking (62.10)', adoptiedatum],
  ].concat(adoptieaktePersoon);

  gegevenDeMeerderjarige(this.context, aanduidingAdoptieouder, moederData.concat(geboorteakteMoeder));

  gegevenDeInBuitenlandGeborenMinderjarige(this.context, aanduidingPersoon, persoonData);
  gegevenDeInBuitenlandGeborenMinderjarigeHeeftEenOuder(this.context, aanduidingPersoon,
    aanduidingAdoptieouder, ouderData, adoptieaktePersoon
  );

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});

// dit is een in het buitenland geboren minderjarige met ouders die niet in de BRP of RNI staan
Given('de minderjarige persoon {string} geboren in het buitenland met niet-ingezeten ouders {string} en {string}', function (aanduidingPersoon, aanduidingOuder1, aanduidingOuder2) {
  const geboorteaktePersoon = [
    ['beschrijving document (82.30)', 'buitenlandse geboorteakte']
  ];

  const persoonData = createPersoonData(aanduidingPersoon, '6029').concat(geboorteaktePersoon);

  const moederData = [
    ['voornamen (02.10)', 'Jane' ],
    ['geslachtsnaam (02.40)', aanduidingOuder1],
    ['geboortedatum (03.10)', geboortedatumMeerderjarige],
    ['geslachtsaanduiding (04.10)', 'V']
  ];

  const vaderData = [
    ['voornamen (02.10)', 'John' ],
    ['geslachtsnaam (02.40)', aanduidingOuder2],
    ['geboortedatum (03.10)', geboortedatumMeerderjarige],
    ['geslachtsaanduiding (04.10)', 'M']
  ];

  gegevenDePersoon(this.context, aanduidingOuder1, arrayOfArraysToDataTable(moederData));
  gegevenDePersoon(this.context, aanduidingOuder2, arrayOfArraysToDataTable(vaderData));

  gegevenDeInBuitenlandGeborenMinderjarige(this.context, aanduidingPersoon, persoonData);
  gegevenDePersoonHeeftAlsOuders(this.context, aanduidingPersoon, aanduidingOuder1, aanduidingOuder2);

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});

// dit is een minderjarige in RNI die nooit ingezetene is geweest
Given('de minderjarige persoon {string} die nooit ingezetene is geweest', function (aanduidingPersoon) {
  const geboorteaktePersoon = [
    ['beschrijving document (82.30)', 'buitenlandse geboorteakte']
  ];

  const persoonData = createPersoonData(aanduidingPersoon, '6029').concat(geboorteaktePersoon);

  const verblijfplaatsData = [
    ['gemeente van inschrijving (09.10)', '1999']
  ];

  const deelnemerData = [
    ['rni-deelnemer (88.10)', '201']
  ];

  opschortingData = [
    ['datum opschorting bijhouding (67.10)', 'gisteren - 1 jaar'],
    ['reden opschorting bijhouding (67.20)', 'R']
  ];

  gegevenDeMinderjarige(this.context, aanduidingPersoon, persoonData.concat(deelnemerData), verblijfplaatsData.concat(deelnemerData));

  aanvullenInschrijving(
    getPersoon(this.context, aanduidingPersoon),
    arrayOfArraysToDataTable(opschortingData)
  );
});

// dit is een in Nederland geboren en ingezeten meerderjarige zonder kinderen
Given('de meerderjarige persoon {string}', function (aanduidingPersoon) {
  const geboorteaktePersoon = [
    ['aktenummer (81.20)', '1XA4800']
  ];

  const persoonData = createPersoonData(aanduidingPersoon, defaultLandCode, partnerBurgerservicenummer, geboortedatumMeerderjarige).concat(geboorteaktePersoon);

  const verblijfplaatsData = [
    ['gemeente van inschrijving (09.10)', '0518']
  ];

  gegevenDeMinderjarige(this.context, aanduidingPersoon, persoonData, verblijfplaatsData);
});
