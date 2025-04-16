const { Given } = require('@cucumber/cucumber');
const { objectToDataTable, arrayOfArraysToDataTable } = require('../dataTableFactory');
const { createOuder, createKind, wijzigPersoon, wijzigGeadopteerdPersoon, wijzigOuder } = require('../persoon-2');
const { getPersoon, getBsn, getGeslachtsnaam, getGeboortedatum, getGeslachtsaanduiding } = require('../contextHelpers');
const { toBRPDate } = require('../brpDatum');
const { toDbColumnName } = require('../brp');
 
function gegevenIsGeadopteerdDoorPersoonAlsOuder(context, aanduidingKind, aanduidingOuder, ouderType, dataTable) {
    const kind = getPersoon(context, aanduidingKind);

    gegevenKindIsGeadopteerdDoorPersoonAlsOuder(context, kind, aanduidingOuder, ouderType, dataTable);
}

function gegevenKindIsGeadopteerdDoorPersoonAlsOuder(context, kind, aanduidingOuder, ouderType, dataTable) {
    const ouder = getPersoon(context, aanduidingOuder);

    const kindData = { ...kind.persoon.at(-1) };

    kindData[toDbColumnName('aktenummer (81.20)')] = '1AQ0100'

    wijzigPersoon(
        kind,
        objectToDataTable(kindData)
    );

    // Bij adoptie van een vondeling wordt de puntouder gewijzigd naar de adoptieouder
    const ouderData = kind[`ouder-${ouderType}`];

    if (ouderType === '1' && ouderData && ouderData[0]?.geslachts_naam === '.') {
        wijzigOuder(
            kind,
            ouderType,
            arrayOfArraysToDataTable([
                ['burgerservicenummer (01.20)', getBsn(ouder)],
                ['geslachtsnaam (02.40)', getGeslachtsnaam(ouder)],
                ['geboortedatum (03.10)', getGeboortedatum(ouder)],
                ['geslachtsaanduiding (04.10)', getGeslachtsaanduiding(ouder)],
            ], dataTable),
            false
        );
    } else {
        createOuder(
            kind,
            ouderType,
            arrayOfArraysToDataTable([
                ['burgerservicenummer (01.20)', getBsn(ouder)],
                ['geslachtsnaam (02.40)', getGeslachtsnaam(ouder)],
                ['geboortedatum (03.10)', getGeboortedatum(ouder)],
                ['geslachtsaanduiding (04.10)', getGeslachtsaanduiding(ouder)]
            ], dataTable)
        );
    }

    createKind(
        ouder,
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(kind)],
            ['geslachtsnaam (02.40)', getGeslachtsnaam(kind)],
            ['geboortedatum (03.10)', getGeboortedatum(kind)],
            ['aktenummer (81.20)', '1AQ0100'],
        ])
    )
}

function gegevenIsGeadopteerd(aanduidingKind, datum, aanduidingOuder) {
    gegevenIsGeadopteerdDoorPersoon(this.context, aanduidingKind, aanduidingOuder, datum);
}

function gegevenIsGeadopteerdDoorPersoon(context, aanduidingKind, aanduidingOuder, datum) {
    const kind = getPersoon(context, aanduidingKind);

    if (datum === undefined) {
        datum = '10 jaar geleden';
    }

    const adoptieOuderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', datum],
        ['aktenummer (81.20)', '1AQ0100']
    ]);

    let ouderType = '1';

    const ouder = kind['ouder-1'];

    if (ouder) {
        if (ouder[0].geslachts_naam === '.') {
            ouderType = '1';
        } else {
            ouderType = '2';
        }
    }

    gegevenKindIsGeadopteerdDoorPersoonAlsOuder(context, kind, aanduidingOuder, ouderType, adoptieOuderData);

    global.logger.info(`persoon '${aanduidingKind}' is '${datum}' geadopteerd door '${aanduidingOuder}'`, getPersoon(context, aanduidingKind));
}

Given('{string} is geadopteerd door {string}', function (aanduidingKind, aanduidingOuder) {
    gegevenIsGeadopteerdDoorPersoon(this.context, aanduidingKind, aanduidingOuder);

    global.logger.info(`persoon '${aanduidingKind}' is geadopteerd door '${aanduidingOuder}'`, getPersoon(this.context, aanduidingKind));
});

Given('{string} is {vandaag, gisteren of morgen x jaar geleden} geadopteerd door {string}', gegevenIsGeadopteerd);

Given('{string} is geadopteerd door {string} en {string}', function (aanduidingKind, aanduidingOuder1, aanduidingOuder2) {
    gegevenIsGeadopteerdDoorPersoon(this.context, aanduidingKind, aanduidingOuder1);
    gegevenIsGeadopteerdDoorPersoon(this.context, aanduidingKind, aanduidingOuder2);

    global.logger.info(`persoon '${aanduidingKind}' is geadopteerd door '${aanduidingOuder1}' en '${aanduidingOuder2}'`, getPersoon(this.context, aanduidingKind));
});

Given(/^is geadopteerd door '(.*)' als ouder ([1-2])$/, function (aanduidingOuder, ouderType) {
    const kind = getPersoon(this.context, undefined);
    const adoptieOuderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', '10 jaar geleden'],
        ['aktenummer (81.20)', '1AQ0100']
    ]);

    gegevenKindIsGeadopteerdDoorPersoonAlsOuder(this.context, kind, aanduidingOuder, ouderType, adoptieOuderData);
});

Given(/^'(.*)' is geadopteerd door '(.*)' als ouder ([1-2])$/, function (aanduidingKind, aanduidingOuder, ouderType) {
    const kind = getPersoon(this.context, aanduidingKind);
    const adoptieOuderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', '10 jaar geleden'],
        ['aktenummer (81.20)', '1AQ0100']
    ]);

    gegevenKindIsGeadopteerdDoorPersoonAlsOuder(this.context, kind, aanduidingOuder, ouderType, adoptieOuderData);
});

Given(/^'(.*)' is op (\d*)-(\d*)-(\d*) geadopteerd door '(.*)' en '(.*)'$/, function (aanduidingKind, dag, maand, jaar, aanduidingOuder1, aanduidingOuder2) {
    const kind = getPersoon(this.context, aanduidingKind);
    const adoptieDatum = toBRPDate(dag, maand, jaar);
    const adoptieOuderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', adoptieDatum],
        ['aktenummer (81.20)', '1AQ0100']
    ]);

    gegevenKindIsGeadopteerdDoorPersoonAlsOuder(this.context, kind, aanduidingOuder1, '1', adoptieOuderData);
    gegevenKindIsGeadopteerdDoorPersoonAlsOuder(this.context, kind, aanduidingOuder2, '2', adoptieOuderData);
});

Given(/^'(.*)' is geadopteerd door '(.*)' als ouder ([1-2]) met de volgende gegevens$/, function (aanduidingKind, aanduidingOuder, ouderType, dataTable) {
    gegevenIsGeadopteerdDoorPersoonAlsOuder(this.context, aanduidingKind, aanduidingOuder, ouderType, dataTable);
});

function gegevenAdoptieVanKindIsHerroepenVoorOuder(context, kind, aanduidingOuder, ouderType, dataTable) {
    const ouder = getPersoon(context, aanduidingOuder);

    const kindData = { ...kind.persoon.at(-1) };
    kindData[toDbColumnName('aktenummer (81.20)')] = '1AR0200'

    wijzigGeadopteerdPersoon(
        kind,
        objectToDataTable(kindData),
        true
    );

    wijzigOuder(
        kind,
        ouderType,
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(ouder)],
            ['geslachtsnaam (02.40)', getGeslachtsnaam(ouder)]
        ], dataTable),
        true
    );
}

Given(/^de adoptie van '(.*)' is herroepen voor '(.*)' als ouder ([1-2])$/, function (aanduidingKind, aanduidingOuder, ouderType) {
    const kind = getPersoon(this.context, aanduidingKind);
    const adoptieOuderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', 'morgen - 2 jaar']
    ]);

    gegevenAdoptieVanKindIsHerroepenVoorOuder(this.context, kind, aanduidingOuder, ouderType, adoptieOuderData);
});

Given(/^is niet in Nederland geadopteerd$/, function () {
    // doe niets
});

Given(/^'(.*)' is in het buitenland geadopteerd door '(.*)' en '(.*)' op (\d*)-(\d*)-(\d*)$/, function (aanduidingKind, aanduidingOuder1, aanduidingOuder2, dag, maand, jaar) {
    return 'pending'
});