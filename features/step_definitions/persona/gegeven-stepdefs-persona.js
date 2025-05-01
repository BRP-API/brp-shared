const { Given } = require('@cucumber/cucumber');
const { arrayOfArraysToDataTable } = require('../dataTableFactory');
const { createPersoon, createOuder, createPartner, createKind, createVerblijfplaats, aanvullenInschrijving } = require('../persoon-2');
const { getPersoon } = require('../contextHelpers');

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

const verblijfplaatsData = [
  ['gemeente van inschrijving (09.10)', '0518']
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

function createIngeschrevenMinderjarige(context, aanduidingPersoon, persoonData, verblijfplaatsData, ouder1Data, ouder2Data) {
  createPersoon(
    context,
    aanduidingPersoon,
    persoonData
  );

  // categorie verblijfplaats van persoon
  createVerblijfplaats(
    getPersoon(context, aanduidingPersoon),
    verblijfplaatsData
  );

  // categorie ouder 1 van persoon
  if (ouder1Data) {
    createOuder(
      getPersoon(context, aanduidingPersoon),
      '1',
      ouder1Data
    );
  }

  // categorie ouder 2 van persoon
  if (ouder2Data) {
    createOuder(
      getPersoon(context, aanduidingPersoon),
      '2',
      ouder2Data
    );
  }
}

function createOuderMetKind(context, aanduidingOuder, ouderData, kindData) {
  // maak pl van ouder
  createPersoon(
    context,
    aanduidingOuder,
    ouderData
  );

  // categorie kind van ouder
  if (kindData) {
    createKind(
      getPersoon(context, aanduidingOuder),
      kindData
    );
  }
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

  // maak pl van ouder 1
  createOuderMetKind(this.context, aanduidingOuder1,
    arrayOfArraysToDataTable(moederData, arrayOfArraysToDataTable(geboorteakteMoeder)),
    arrayOfArraysToDataTable(persoonData, arrayOfArraysToDataTable(geboorteaktePersoon))
  );

  // maak pl van ouder 2
  createOuderMetKind(this.context, aanduidingOuder2,
    arrayOfArraysToDataTable(vaderData, arrayOfArraysToDataTable(geboorteakteVader)),
    arrayOfArraysToDataTable(persoonData, arrayOfArraysToDataTable(erkenningAkte))
  );

  // maak pl van minderjarige
  createIngeschrevenMinderjarige(this.context, aanduidingPersoon,
    arrayOfArraysToDataTable(persoonData, arrayOfArraysToDataTable(geboorteaktePersoon)),
    arrayOfArraysToDataTable(verblijfplaatsData),
    arrayOfArraysToDataTable(ouderData, arrayOfArraysToDataTable(moederData, arrayOfArraysToDataTable(geboorteaktePersoon))),
    arrayOfArraysToDataTable(ouderData, arrayOfArraysToDataTable(vaderData, arrayOfArraysToDataTable(erkenningAkte)))
  );

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);

  global.logger.info(`de minderjarige persoon '${aanduidingPersoon}' met twee ouders '${aanduidingOuder1}' en '${aanduidingOuder2}' die ten tijde van de geboorte van de minderjarige niet met elkaar gehuwd waren`, getPersoon(this.context, aanduidingPersoon));
});

// dit is een in Nederland geboren minderjarige met een moeder en een vader die met elkaar gehuwd zijn
Given('de minderjarige persoon {string} met twee gehuwde ouders {string} en {string}', function (aanduidingPersoon, aanduidingOuder1, aanduidingOuder2) {

  const persoonData = createPersoonData(aanduidingPersoon);

  const moederData = createOuderData(ouder1Burgerservicenummer, aanduidingOuder1, geboortedatumMeerderjarige, 'V');

  const vaderData = createOuderData(ouder2Burgerservicenummer, aanduidingOuder2, geboortedatumMeerderjarige, 'M');

  const ouderRelatieData = [
    ['datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)', 'gisteren - 20 jaar'],
    ['plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)', '0518'],
    ['land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)', '6030'],
    ['soort verbintenis (15.10)', 'H'],
    ['aktenummer (81.20)', '3XA1224']
  ]

  const ouderData = [
    ['datum ingang familierechtelijke betrekking (62.10)', geboortedatumMinderjarige],
    ['aktenummer (81.20)', '1XA3600']
  ];

  // maak pl van ouder 1
  createOuderMetKind(this.context, aanduidingOuder1,
    arrayOfArraysToDataTable(moederData, arrayOfArraysToDataTable(geboorteakteMoeder)),
    arrayOfArraysToDataTable(persoonData, arrayOfArraysToDataTable(geboorteaktePersoon))
  );

  // maak pl van ouder 2
  createOuderMetKind(this.context, aanduidingOuder2,
    arrayOfArraysToDataTable(vaderData, arrayOfArraysToDataTable(geboorteakteVader)),
    arrayOfArraysToDataTable(persoonData, arrayOfArraysToDataTable(geboorteaktePersoon))
  );

  // maak pl van minderjarige
  createIngeschrevenMinderjarige(this.context, aanduidingPersoon,
    arrayOfArraysToDataTable(persoonData, arrayOfArraysToDataTable(geboorteaktePersoon)),
    arrayOfArraysToDataTable(verblijfplaatsData),
    arrayOfArraysToDataTable(ouderData, arrayOfArraysToDataTable(moederData)),
    arrayOfArraysToDataTable(ouderData, arrayOfArraysToDataTable(vaderData))
  );

  // categorie partner van moeder
  createPartner(
    getPersoon(this.context, aanduidingOuder1),
    arrayOfArraysToDataTable(vaderData, arrayOfArraysToDataTable(ouderRelatieData))
  );

  // categorie partner van vader
  createPartner(
    getPersoon(this.context, aanduidingOuder2),
    arrayOfArraysToDataTable(moederData, arrayOfArraysToDataTable(ouderRelatieData))
  );

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});

// dit is een in Nederland geboren minderjarige met een moeder die ongehuwd is en geen tweede ouder
Given('de minderjarige persoon {string} met één ouder {string}', function(aanduidingPersoon, aanduidingOuder1) {
  const persoonData = createPersoonData(aanduidingPersoon);

  const moederData = createOuderData(ouder1Burgerservicenummer, aanduidingOuder1, geboortedatumMeerderjarige, 'V');

  const ouderData = [
    ['datum ingang familierechtelijke betrekking (62.10)', geboortedatumMinderjarige],
    ['aktenummer (81.20)', '1XA3600']
  ];

  const legeOuderData = [
    ['aktenummer (81.20)', '1XA3600'],
    ['datum ingang geldigheid (85.10)', geboortedatumMinderjarige]
  ]

  // maak pl van ouder 1
  createOuderMetKind(this.context, aanduidingOuder1,
    arrayOfArraysToDataTable(moederData, arrayOfArraysToDataTable(geboorteakteMoeder)),
    arrayOfArraysToDataTable(persoonData, arrayOfArraysToDataTable(geboorteaktePersoon))
  );

  // maak pl van minderjarige
  createIngeschrevenMinderjarige(this.context, aanduidingPersoon,
    arrayOfArraysToDataTable(persoonData, arrayOfArraysToDataTable(geboorteaktePersoon)),
    arrayOfArraysToDataTable(verblijfplaatsData),
    arrayOfArraysToDataTable(ouderData, arrayOfArraysToDataTable(moederData)),
    arrayOfArraysToDataTable(legeOuderData)
  );

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

  const ouderRelatieData = [
    ['datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)', 'gisteren - 20 jaar'],
    ['plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)', '0518'],
    ['land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)', '6030'],
    ['soort verbintenis (15.10)', 'H'],
    ['aktenummer (81.20)', '3XA1224']
  ]

  const ouderData = [
    ['datum ingang familierechtelijke betrekking (62.10)', geboortedatumMinderjarige],
    ['aktenummer (81.20)', '1XA3600']
  ];

  const legeOuderData = [
    ['aktenummer (81.20)', '1XA3600'],
    ['datum ingang geldigheid (85.10)', geboortedatumMinderjarige]
  ]

  // maak pl van ouder 1
  createOuderMetKind(this.context, aanduidingOuder1,
    arrayOfArraysToDataTable(moederData, arrayOfArraysToDataTable(geboorteakteMoeder)),
    arrayOfArraysToDataTable(persoonData, arrayOfArraysToDataTable(geboorteaktePersoon))
  );

  // maak pl van partner van ouder 1
  createOuderMetKind(this.context, aanduidingPartner,
    arrayOfArraysToDataTable(partnerData, arrayOfArraysToDataTable(geboorteaktePartner)),
    undefined
  );

  // maak pl van minderjarige
  createIngeschrevenMinderjarige(this.context, aanduidingPersoon,
    arrayOfArraysToDataTable(persoonData, arrayOfArraysToDataTable(geboorteaktePersoon)),
    arrayOfArraysToDataTable(verblijfplaatsData),
    arrayOfArraysToDataTable(ouderData, arrayOfArraysToDataTable(moederData)),
    arrayOfArraysToDataTable(legeOuderData)
  );

  // categorie partner op pl van moeder
  createPartner(
    getPersoon(this.context, aanduidingOuder1),
    arrayOfArraysToDataTable(partnerData, arrayOfArraysToDataTable(ouderRelatieData))
  );

  // categorie partner op pl van partner
  createPartner(
    getPersoon(this.context, aanduidingPartner),
    arrayOfArraysToDataTable(moederData, arrayOfArraysToDataTable(ouderRelatieData))
  );

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});

// dit is een in het buitenland geboren minderjarige met een moeder en een vader die met elkaar gehuwd zijn en het hele gezin is geïmmigreerd naar Nederland
Given('de minderjarige persoon {string} geboren in het buitenland met twee gehuwde ouders {string} en {string}', function (aanduidingPersoon, aanduidingOuder1, aanduidingOuder2) {
  const persoonData = createPersoonData(aanduidingPersoon, '6029');

  const geboorteaktePersoon = [
    ['beschrijving document (82.30)', 'buitenlandse geboorteakte']
  ];

  const verblijfplaatsData = [
    ['gemeente van inschrijving (09.10)', '0518'],
    ['land vanwaar ingeschreven (14.10)', '6029'],
    ['datum vestiging in Nederland (14.20)', 'gisteren - 5 jaar'],
  ];

  const moederData = createOuderData(ouder1Burgerservicenummer, aanduidingOuder1, geboortedatumMeerderjarige, 'V');

  const geboorteakteMoeder = [
    ['beschrijving document (82.30)', 'paspoort']
  ];

  const vaderData = createOuderData(ouder2Burgerservicenummer, aanduidingOuder2, geboortedatumMeerderjarige, 'M');

  const geboorteakteVader = [
    ['beschrijving document (82.30)', 'beëdigde verklaring']
  ];

  const ouderRelatieData = [
    ['datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)', 'gisteren - 20 jaar'],
    ['plaats huwelijkssluiting/aangaan geregistreerd partnerschap (06.20)', 'Teststadt'],
    ['land huwelijkssluiting/aangaan geregistreerd partnerschap (06.30)', '6029'],
    ['soort verbintenis (15.10)', 'H'],
    ['beschrijving document (82.30)', 'buitenlandse huwelijkseakte']
  ]

  const ouderData = [
    ['datum ingang familierechtelijke betrekking (62.10)', geboortedatumMinderjarige],
    ['beschrijving document (82.30)', 'buitenlandse geboorteakte']
  ];

  // maak pl van ouder 1
  createOuderMetKind(this.context, aanduidingOuder1,
    arrayOfArraysToDataTable(moederData, arrayOfArraysToDataTable(geboorteakteMoeder)),
    arrayOfArraysToDataTable(persoonData, arrayOfArraysToDataTable(geboorteaktePersoon))
  );

  // maak pl van ouder 2
  createOuderMetKind(this.context, aanduidingOuder2,
    arrayOfArraysToDataTable(vaderData, arrayOfArraysToDataTable(geboorteakteVader)),
    arrayOfArraysToDataTable(persoonData, arrayOfArraysToDataTable(geboorteaktePersoon))
  );

  // maak pl van minderjarige
  createIngeschrevenMinderjarige(this.context, aanduidingPersoon,
    arrayOfArraysToDataTable(persoonData, arrayOfArraysToDataTable(geboorteaktePersoon)),
    arrayOfArraysToDataTable(verblijfplaatsData),
    arrayOfArraysToDataTable(ouderData, arrayOfArraysToDataTable(moederData)),
    arrayOfArraysToDataTable(ouderData, arrayOfArraysToDataTable(vaderData))
  );

  // categorie partner van moeder
  createPartner(
    getPersoon(this.context, aanduidingOuder1),
    arrayOfArraysToDataTable(vaderData, arrayOfArraysToDataTable(ouderRelatieData))
  );

  // categorie partner van vader
  createPartner(
    getPersoon(this.context, aanduidingOuder2),
    arrayOfArraysToDataTable(moederData, arrayOfArraysToDataTable(ouderRelatieData))
  );

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});

// dit is een in het buitenland geboren minderjarige met een moeder en minderjarige en moeder zijn geïmmigreerd naar Nederland
Given('de minderjarige persoon {string} geboren in het buitenland met één ouder {string}', function (aanduidingPersoon, aanduidingOuder1) {
  const persoonData = createPersoonData(aanduidingPersoon, '6029');

  const geboorteaktePersoon = [
    ['beschrijving document (82.30)', 'buitenlandse geboorteakte']
  ];

  const verblijfplaatsData = [
    ['gemeente van inschrijving (09.10)', '0518'],
    ['land vanwaar ingeschreven (14.10)', '6029'],
    ['datum vestiging in Nederland (14.20)', 'gisteren - 5 jaar'],
  ];

  const moederData = createOuderData(ouder1Burgerservicenummer, aanduidingOuder1, geboortedatumMeerderjarige, 'V');

  const geboorteakteMoeder = [
    ['beschrijving document (82.30)', 'paspoort']
  ];

  const ouderData = [
    ['datum ingang familierechtelijke betrekking (62.10)', geboortedatumMinderjarige],
    ['beschrijving document (82.30)', 'buitenlandse geboorteakte']
  ];

  const legeOuderData = [
    ['beschrijving document (82.30)', 'buitenlandse geboorteakte'],
    ['datum ingang geldigheid (85.10)', geboortedatumMinderjarige]
  ]

  // maak pl van ouder 1
  createOuderMetKind(this.context, aanduidingOuder1,
    arrayOfArraysToDataTable(moederData, arrayOfArraysToDataTable(geboorteakteMoeder)),
    arrayOfArraysToDataTable(persoonData, arrayOfArraysToDataTable(geboorteaktePersoon))
  );

  // maak pl van minderjarige
  createIngeschrevenMinderjarige(this.context, aanduidingPersoon,
    arrayOfArraysToDataTable(persoonData, arrayOfArraysToDataTable(geboorteaktePersoon)),
    arrayOfArraysToDataTable(verblijfplaatsData),
    arrayOfArraysToDataTable(ouderData, arrayOfArraysToDataTable(moederData)),
    arrayOfArraysToDataTable(legeOuderData)
  );

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});

// dit is een in het buitenland geboren minderjarige die is geadopteerd door één ouder
Given('de minderjarige persoon {string} geboren in het buitenland geadopteerd door één ouder {string}', function (aanduidingPersoon, aanduidingAdoptieouder) {
  const adoptiedatum = 'gisteren - 15 jaar'

  const persoonData = createPersoonData(aanduidingPersoon, '6029');

  const adoptieaktePersoon = [
    ['aktenummer (81.20)', '1XQ2436']
  ];

  const verblijfplaatsData = [
    ['gemeente van inschrijving (09.10)', '0518'],
    ['land vanwaar ingeschreven (14.10)', '6029'],
    ['datum vestiging in Nederland (14.20)', 'gisteren - 5 jaar'],
  ];

  const moederData = createOuderData(adoptieOuder1Burgerservicenummer, aanduidingAdoptieouder, geboortedatumMeerderjarige, 'V');

  const geboorteakteMoeder = [
    ['beschrijving document (82.30)', 'paspoort']
  ];

  const ouderData = [
    ['datum ingang familierechtelijke betrekking (62.10)', adoptiedatum],
    ['aktenummer (81.20)', '1XQ2436']
  ];

  const legeOuderData = [
    ['beschrijving document (82.30)', 'buitenlandse geboorteakte'],
    ['datum ingang geldigheid (85.10)', geboortedatumMinderjarige]
  ]

  // maak pl van ouder 1 (adoptiemoeder)
  createOuderMetKind(this.context, aanduidingAdoptieouder,
    arrayOfArraysToDataTable(moederData, arrayOfArraysToDataTable(geboorteakteMoeder)),
    arrayOfArraysToDataTable(persoonData, arrayOfArraysToDataTable(adoptieaktePersoon))
  );

  // maak pl van minderjarige
  createIngeschrevenMinderjarige(this.context, aanduidingPersoon,
    arrayOfArraysToDataTable(persoonData, arrayOfArraysToDataTable(adoptieaktePersoon)),
    arrayOfArraysToDataTable(verblijfplaatsData),
    arrayOfArraysToDataTable(ouderData, arrayOfArraysToDataTable(moederData)),
    arrayOfArraysToDataTable(legeOuderData)
  );

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});

// dit is een in het buitenland geboren minderjarige met ouders die niet in de BRP of RNI staan
Given('de minderjarige persoon {string} geboren in het buitenland met niet-ingezeten ouders {string} en {string}', function (aanduidingPersoon, aanduidingOuder1, aanduidingOuder2) {
  const persoonData = createPersoonData(aanduidingPersoon, '6029');
  persoonData.push(['beschrijving document (82.30)', 'buitenlandse geboorteakte']);

  const verblijfplaatsData = [
    ['gemeente van inschrijving (09.10)', '0518'],
    ['land vanwaar ingeschreven (14.10)', '6029'],
    ['datum vestiging in Nederland (14.20)', 'gisteren - 5 jaar'],
  ];

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

  const ouderData = [
    ['datum ingang familierechtelijke betrekking (62.10)', geboortedatumMinderjarige],
    ['beschrijving document (82.30)', 'buitenlandse geboorteakte']
  ];

  // maak pl van minderjarige
  createIngeschrevenMinderjarige(this.context, aanduidingPersoon,
    arrayOfArraysToDataTable(persoonData),
    arrayOfArraysToDataTable(verblijfplaatsData),
    arrayOfArraysToDataTable(ouderData, arrayOfArraysToDataTable(moederData)),
    arrayOfArraysToDataTable(ouderData, arrayOfArraysToDataTable(vaderData))
  );

  // zet context naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});

// dit is een minderjarige in RNI die nooit ingezetene is geweest
Given('de minderjarige persoon {string} die nooit ingezetene is geweest', function (aanduidingPersoon) {
  const persoonData = createPersoonData(aanduidingPersoon, '6029');
  persoonData.push(['beschrijving document (82.30)', 'buitenlandse geboorteakte']);

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

  // maak pl van minderjarige
  createIngeschrevenMinderjarige(this.context, aanduidingPersoon,
    arrayOfArraysToDataTable(persoonData.concat(deelnemerData)),
    arrayOfArraysToDataTable(verblijfplaatsData.concat(deelnemerData)),
    undefined,
    undefined
  );

  aanvullenInschrijving(
    getPersoon(this.context, aanduidingPersoon),
    arrayOfArraysToDataTable(opschortingData)
  );
});

// dit is een in Nederland geboren en ingezeten meerderjarige zonder kinderen
Given('de meerderjarige persoon {string}', function (aanduidingPersoon) {
  const persoonData = createPersoonData(aanduidingPersoon, defaultLandCode, partnerBurgerservicenummer, geboortedatumMeerderjarige);

  const geboorteaktePersoon = [
    ['aktenummer (81.20)', '1XA4800']
  ];

  const verblijfplaatsData = [
    ['gemeente van inschrijving (09.10)', '0518']
  ];

  // maak pl van de meerderjarige
  createIngeschrevenMinderjarige(this.context, aanduidingPersoon,
    arrayOfArraysToDataTable(persoonData, arrayOfArraysToDataTable(geboorteaktePersoon)),
    arrayOfArraysToDataTable(verblijfplaatsData),
    undefined,
    undefined
  );
});
