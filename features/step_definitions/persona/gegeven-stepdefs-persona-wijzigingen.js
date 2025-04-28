const { Given } = require('@cucumber/cucumber');
const { objectToDataTable, arrayOfArraysToDataTable } = require('../dataTableFactory');
const { createPersoon, createKind, wijzigPersoon, wijzigOuder } = require('../persoon-2');
const { getPersoon } = require('../contextHelpers');
const { toDbColumnName } = require('../brp');

// **************************************************************************************************************
//                     functies "geleend" uit expressief/gegeven-stepdefs-*
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
//                     extra functies voor toevoegen, aanvullen of wijzigen van gegevens
// **************************************************************************************************************

function beschikbareOuder(persoon) { 
  if(!persoon['ouder-1'] ) {
    return 1
  } 
  if (persoon['ouder-1'] && !persoon['ouder-1'][0]['geslachts_naam']) {
    return 1
  }
  if (persoon['ouder-1'] && persoon['ouder-1'][0]['geslachts_naam'] == '.') {
    return 1
  }

  return 2
}

// **************************************************************************************************************
//                     aanvullende Gegeven stappen
// **************************************************************************************************************

const ouder1Burgerservicenummer        = '000000101'
const ouder2Burgerservicenummer        = '000000102'
const persoonBurgerservicenummer       = '000000103'
const adoptieOuder1Burgerservicenummer = '000000104'
const adoptieOuder2Burgerservicenummer = '000000105'
const partnerBurgerservicenummer       = '000000106'

const geboortedatumMinderjarige  = 'gisteren - 16 jaar'
const geboortedatumMeerderjarige = 'morgen - 37 jaar'

// maakt de adoptieouder als meerderjarige persoon en legt ouder-kind relatie tussen de persoon in context en de adoptieouder
Given('is {vandaag, gisteren of morgen x jaar geleden} geadopteerd door Nederlandse adoptieouder {string} met een Nederlandse adoptieakte', function (adoptieDatum, aanduidingAdoptieOuder) {
  if (/(\d+) jaar geleden/.test(adoptieDatum)) {
    const years = adoptieDatum.match(/(\d+)/)[0];
    adoptieDatum = `vandaag - ${years} jaar`;
  }

  const adoptieOuderData = [
    ['burgerservicenummer (01.20)', adoptieOuder1Burgerservicenummer],
    ['geslachtsnaam (02.40)', aanduidingAdoptieOuder],
    ['geboortedatum (03.10)', geboortedatumMeerderjarige],
    ['geslachtsaanduiding (04.10)', 'M']
  ];

  const geboorteakteAdoptieOuder = [
    ['aktenummer (81.20)', '1XA2400'],
    ['beschrijving document (82.30)', '']
  ];

  const adoptieData = [
      ['datum ingang familierechtelijke betrekking (62.10)', adoptieDatum],
      ['aktenummer (81.20)', '1XQ2436'],
      ['beschrijving document (82.30)', '']
  ];

  persoon = getPersoon(this.context, undefined);
  const aanduidingPersoon = persoon.id.substr(8)

  const persoonData = { ...persoon.persoon.at(-1) };
  persoonData[toDbColumnName('aktenummer (81.20)')] = '1XQ2436';
  persoonData[toDbColumnName('beschrijving document (82.30)')] = '';

  // bepaal de eerst beschikbare ouder categorie
  let adoptieOuderType = beschikbareOuder(persoon);

  // zet adoptieakte bij persoon
  wijzigPersoon(
    persoon,
    objectToDataTable(persoonData)
  );

  // wijzig ouder van persoon
  wijzigOuder(persoon, adoptieOuderType, arrayOfArraysToDataTable(adoptieOuderData, arrayOfArraysToDataTable(adoptieData)), isCorrectie = false) 

  if (!getPersoon(this.context, aanduidingAdoptieOuder)) {
    // maak pl van adoptieouder
    createPersoon(
      this.context,
      aanduidingAdoptieOuder,
      arrayOfArraysToDataTable(adoptieOuderData, arrayOfArraysToDataTable(geboorteakteAdoptieOuder))
    );
  }

  // categorie kind van adoptieouder
  createKind(
    getPersoon(this.context, aanduidingAdoptieOuder),
    objectToDataTable(persoonData)
  );

  // zet context terug naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});

// maakt de adoptieouders als meerderjarige personen en legt ouder-kind relaties tussen de persoon in context en de adoptieouders
Given('is {vandaag, gisteren of morgen x jaar geleden} geadopteerd door twee Nederlandse adoptieouders {string} en {string} met een Nederlandse adoptieakte', function(adoptieDatum, aanduidingOuder1, aanduidingOuder2) {
  if (/(\d+) jaar geleden/.test(adoptieDatum)) {
    const years = adoptieDatum.match(/(\d+)/)[0];
    adoptieDatum = `vandaag - ${years} jaar`;
  }

  const adoptiemoederData = [
    ['burgerservicenummer (01.20)', adoptieOuder1Burgerservicenummer],
    ['geslachtsnaam (02.40)', aanduidingOuder1],
    ['geboortedatum (03.10)', geboortedatumMeerderjarige],
    ['geslachtsaanduiding (04.10)', 'V']
  ];

  const geboorteakteAdoptieMoeder = [
    ['aktenummer (81.20)', '1XA1200']
  ];

  const adoptievaderData = [
    ['burgerservicenummer (01.20)', adoptieOuder2Burgerservicenummer],
    ['geslachtsnaam (02.40)', aanduidingOuder2],
    ['geboortedatum (03.10)', geboortedatumMeerderjarige],
    ['geslachtsaanduiding (04.10)', 'M']
  ];

  const geboorteakteAdoptieVader = [
    ['aktenummer (81.20)', '1XA2400']
  ];

  const adoptieData = [
      ['datum ingang familierechtelijke betrekking (62.10)', adoptieDatum],
      ['aktenummer (81.20)', '1XQ1224']
  ];

  persoon = getPersoon(this.context, undefined);
  const aanduidingPersoon = persoon.id.substr(8)

  const persoonData = { ...persoon.persoon.at(-1) };
  persoonData[toDbColumnName('aktenummer (81.20)')] = '1XQ2436';
  persoonData[toDbColumnName('beschrijving document (82.30)')] = ''

  // zet adoptieakte bij persoon
  wijzigPersoon(
    persoon,
    objectToDataTable(persoonData)
  );

  // wijzig ouders van persoon
  wijzigOuder(persoon, 1, arrayOfArraysToDataTable(adoptiemoederData, arrayOfArraysToDataTable(adoptieData)), isCorrectie = false) 
  wijzigOuder(persoon, 2, arrayOfArraysToDataTable(adoptievaderData, arrayOfArraysToDataTable(adoptieData)), isCorrectie = false) 

  // maak pl van adoptiemoeder
  createPersoon(
    this.context,
    aanduidingOuder1,
    arrayOfArraysToDataTable(adoptiemoederData, arrayOfArraysToDataTable(geboorteakteAdoptieMoeder))
  );

  // maak pl van adoptievader
  createPersoon(
    this.context,
    aanduidingOuder2,
    arrayOfArraysToDataTable(adoptievaderData, arrayOfArraysToDataTable(geboorteakteAdoptieVader))
  );

  // categorie kind van adoptiemoeder
  createKind(
    getPersoon(this.context, aanduidingOuder1),
    objectToDataTable(persoonData)
  );

  // categorie kind van adoptievader
  createKind(
    getPersoon(this.context, aanduidingOuder2),
    objectToDataTable(persoonData)
  );

  // zet context terug naar de minderjarige persoon
  wijzigPersoonContext(this.context, aanduidingPersoon);
});
 