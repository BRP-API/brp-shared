const { Given } = require('@cucumber/cucumber');
const { createOuder, createKind, wijzigPersoon, wijzigOuder } = require('../persoon-2');
const { getPersoon,
        getBsn,
        getGeslachtsnaam,
        getGeboortedatum,
        getGeslachtsaanduiding,
        persoonPropertiesToArrayofArrays } = require('../contextHelpers');
const { arrayOfArraysToDataTable, objectToDataTable } = require('../dataTableFactory');
const { toBRPDate } = require('../brpDatum');
const { toDbColumnName } = require('../brp');

const ErkenningsType = {
    ErkenningBijGeboorteaangifte: 'B',
    ErkenningNaGeboorteaangifte: 'C',
    ErkenningBijNotarieleAkte: 'J',
    GerechtelijkeVaststellingOuderschap: 'V'
}

Given('{string} is erkend door {string} op {int}-{int}-{int}', function (aanduiding, aanduidingOuder, dag, maand, jaar) {
    const datumIngang = toBRPDate(dag, maand, jaar);

    const ouderData = [
        ['datum ingang familierechtelijke betrekking (62.10)', datumIngang]
    ];

    const geslachtsAanduiding = getGeslachtsaanduiding(getPersoon(this.context, aanduidingOuder));
    if (geslachtsAanduiding) {
        ouderData.push(['geslachtsaanduiding (04.10)', geslachtsAanduiding]);
    }

    const geboorteDatum = getGeboortedatum(getPersoon(this.context, aanduidingOuder));
    if (geboorteDatum) {
        ouderData.push(['geboortedatum (03.10)', geboorteDatum]);
    }

    const aanduidingOuderType = getPersoon(this.context, aanduiding)[`ouder-1`] ? '2' : '1';

    gegevenIsErkendDoorPersoonAlsOuder(this.context, aanduidingOuder, ErkenningsType.ErkenningNaGeboorteaangifte, aanduidingOuderType, arrayOfArraysToDataTable(ouderData));

    global.logger.info(`gegeven persoon is erkend door '${aanduidingOuder}'`, getPersoon(this.context, undefined));
});


Given(/^is erkend door '(.*)' als ouder ([1-2]) met erkenning bij geboorteaangifte$/, function (aanduidingOuder, ouderType) {
    const kind = getPersoon(this.context, null);
    const kindData = { ...kind.persoon.at(-1) };

    const ouderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', kindData.geboorte_datum]
    ]);

    gegevenIsErkendDoorPersoonAlsOuder(this.context, aanduidingOuder, ErkenningsType.ErkenningBijGeboorteaangifte, ouderType, ouderData);
});

Given(/^is erkend door '(.*)' als ouder ([1-2]) met erkenning na geboorteaangifte op (\d*)-(\d*)-(\d*)$/, function (aanduidingOuder, ouderType, dag, maand, jaar) {
    const ouderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', toBRPDate(dag, maand, jaar)]
    ]);

    gegevenIsErkendDoorPersoonAlsOuder(this.context, aanduidingOuder, ErkenningsType.ErkenningNaGeboorteaangifte, ouderType, ouderData);
});

Given(/^is erkend door '(.*)' als ouder ([1-2]) met erkenning bij notariële akte op (\d*)-(\d*)-(\d*)$/, function (aanduidingOuder, ouderType, dag, maand, jaar) {
    const ouderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', toBRPDate(dag, maand, jaar)]
    ]);

    gegevenIsErkendDoorPersoonAlsOuder(this.context, aanduidingOuder, ErkenningsType.ErkenningBijNotarieleAkte, ouderType, ouderData);
});

Given(/^is erkend door '(.*)' als ouder ([1-2]) met gerechtelijke vaststelling ouderschap op (\d*)-(\d*)-(\d*)$/, function (aanduidingOuder, ouderType, dag, maand, jaar) {
    const ouderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', toBRPDate(dag, maand, jaar)]
    ]);

    gegevenIsErkendDoorPersoonAlsOuder(this.context, aanduidingOuder, ErkenningsType.GerechtelijkeVaststellingOuderschap, ouderType, ouderData);
});

Given(/^'(.*)' is erkend door '(.*)' bij geboorteaangifte$/, function (aanduidingPersoon, aanduidingOuder) {
    persoon = getPersoon(this.context, aanduidingPersoon);
  
    const ouderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', { ...persoon.persoon.at(-1) }['geboorte_datum']]
    ]);
  
    ouderType = beschikbareOuder(persoon);
  
    gegevenIsErkendDoorPersoonAlsOuder(this.context, aanduidingOuder, ErkenningsType.ErkenningBijGeboorteaangifte, ouderType, ouderData);
});
  
Given(/^'(.*)' is erkend door '(.*)' (na geboorteaangifte|bij notariële akte|met gerechtelijke vaststelling ouderschap) op (\d*)-(\d*)-(\d*)$/, function (aanduidingPersoon, aanduidingOuder, soortErkenning, dag, maand, jaar) {
    persoon = getPersoon(this.context, aanduidingPersoon);
  
    const ouderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', toBRPDate(dag, maand, jaar)]
    ]);

    ouderType = beschikbareOuder(persoon);
  
    let akteCodeErkenning = 'A'
    switch (soortErkenning) {
        case 'na geboorteaangifte': 
            akteCodeErkenning = ErkenningsType.ErkenningNaGeboorteaangifte; 
            break;
        case 'bij notariële akte': 
            akteCodeErkenning = ErkenningsType.ErkenningBijNotarieleAkte; 
            break;
        case 'met gerechtelijke vaststelling ouderschap': 
            akteCodeErkenning = ErkenningsType.GerechtelijkeVaststellingOuderschap; 
            break;
    }
  
    gegevenIsErkendDoorPersoonAlsOuder(this.context, aanduidingOuder, akteCodeErkenning, ouderType, ouderData);
});

function gegevenIsErkendDoorPersoonAlsOuder(context, aanduidingOuder, erkenningsType, ouderType, dataTable) {
    if (!erkenningsType) {
        erkenningsType = ErkenningsType.ErkenningBijGeboorteaangifte;
    }

    const kind = getPersoon(context, null);
    const ouder = getPersoon(context, aanduidingOuder);

    const kindData = { ...kind.persoon.at(-1) };
    kindData[toDbColumnName('aktenummer (81.20)')] = `1A${erkenningsType}0100`

    wijzigPersoon(
        kind,
        objectToDataTable(kindData)
    );

    if(kind[`ouder-${ouderType}`]) {
        wijzigOuder(
            kind,
            ouderType,
            arrayOfArraysToDataTable([
                ['burgerservicenummer (01.20)', getBsn(ouder)],
                ['geslachtsnaam (02.40)', getGeslachtsnaam(ouder)],
                ['aktenummer (81.20)', `1A${erkenningsType}0100`]
            ], dataTable)
        );
    }
    else {
        createOuder(
            kind,
            ouderType,
            arrayOfArraysToDataTable([
                ['burgerservicenummer (01.20)', getBsn(ouder)],
                ['geslachtsnaam (02.40)', getGeslachtsnaam(ouder)],
                ['aktenummer (81.20)', `1A${erkenningsType}0100`]
            ], dataTable)
        );
    }

    const data = [
        ['burgerservicenummer (01.20)', getBsn(kind)],
        ['geslachtsnaam (02.40)', getGeslachtsnaam(kind)],
        ['aktenummer (81.20)', `1A${erkenningsType}0100`]
    ];

    if (kindData.geboorte_datum) {
        data.push(['geboortedatum (03.10)', kindData.geboorte_datum]);
    }

    createKind(
        ouder,
        arrayOfArraysToDataTable(data)
    )
}

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

function createKindData(kind, aktenr) {
    let retval = [];

    retval.push(['aktenummer (81.20)', aktenr]);

    return retval;
}

function createOuderData(kind, ouder, aktenummer) {
    let retval = createKindData(kind, aktenummer);

    const geboorteDatum = getGeboortedatum(kind);
    if(geboorteDatum) {
        retval.push([
            ouder
                ? 'datum ingang familierechtelijke betrekking (62.10)'
                : 'datum ingang geldigheid (85.10)',
            geboorteDatum]);
    }

    return retval;
}

function createKindEnWijzigOuder(kind, ouder, ouderType, aktenummer) {
    const ouderData = persoonPropertiesToArrayofArrays(ouder).concat(createOuderData(kind, ouder, aktenummer));
    wijzigOuder(kind, ouderType, arrayOfArraysToDataTable(ouderData));

    if(ouder) {
        const kindData = persoonPropertiesToArrayofArrays(kind).concat(createKindData(kind, aktenummer));
        createKind(ouder, arrayOfArraysToDataTable(kindData));
    }
}

function gegevenDePersoonIsBijGeboorteaangifteErkendDoor(context, aanduiding, aanduidingOuder) {
    const kind = getPersoon(context, aanduiding);
    const erkenner = getPersoon(context, aanduidingOuder);
    const ouderType = '2'; // todo ouder type bepalen adhv lege ouder want ouder 1 en 2 zijn beide gevuld

    createKindEnWijzigOuder(kind, erkenner, ouderType, '1XB3624');
}

module.exports = {
    gegevenDePersoonIsBijGeboorteaangifteErkendDoor
};