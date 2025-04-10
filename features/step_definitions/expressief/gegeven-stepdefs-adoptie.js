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

    createOuder(
        kind,
        ouderType,
        arrayOfArraysToDataTable([
            ['burgerservicenummer (01.20)', getBsn(ouder)],
            ['geslachtsnaam (02.40)', getGeslachtsnaam(ouder)],
            ['geboortedatum (03.10)', getGeboortedatum(ouder)],
            ['geslachtsaanduiding (04.10)', getGeslachtsaanduiding(ouder)],
        ], dataTable)
    );

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

Given('{string} is geadopteerd door {string}', function (aanduidingKind, aanduidingOuder1) {
    const kind = getPersoon(this.context, aanduidingKind);
    const adoptieOuderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', '10 jaar geleden'],
        ['aktenummer (81.20)', '1AQ0100']
    ]);

    const ouderType = kind['ouder-1'] ? '2' : '1';

    gegevenKindIsGeadopteerdDoorPersoonAlsOuder(this.context, kind, aanduidingOuder1, ouderType, adoptieOuderData);

    global.logger.info(`persoon '${aanduidingKind}' is geadopteerd door '${aanduidingOuder1}'`, getPersoon(this.context, aanduidingKind));
});

Given('{string} is geadopteerd door {string} en {string}', function (aanduidingKind, aanduidingOuder1, aanduidingOuder2) {
    const kind = getPersoon(this.context, aanduidingKind);
    const adoptieOuderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', '10 jaar geleden'],
        ['aktenummer (81.20)', '1AQ0100']
    ]);

    gegevenKindIsGeadopteerdDoorPersoonAlsOuder(this.context, kind, aanduidingOuder1, '1', adoptieOuderData);
    gegevenKindIsGeadopteerdDoorPersoonAlsOuder(this.context, kind, aanduidingOuder2, '2', adoptieOuderData);

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
    const adoptieOuderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', '10 jaar geleden'],
        ['aktenummer (81.20)', '1AQ0100']
    ]);

    gegevenIsGeadopteerdDoorPersoonAlsOuder(this.context, aanduidingKind, aanduidingOuder, ouderType, adoptieOuderData);
});

Given(/^'(.*)' is op (\d*)-(\d*)-(\d*) geadopteerd door '(.*)' en '(.*)'$/, function (aanduidingKind, dag, maand, jaar, aanduidingOuder1, aanduidingOuder2) {
    const adoptieDatum = toBRPDate(dag, maand, jaar);
    const adoptieOuderData = arrayOfArraysToDataTable([
        ['datum ingang familierechtelijke betrekking (62.10)', adoptieDatum],
        ['aktenummer (81.20)', '1AQ0100']
    ]);

    gegevenIsGeadopteerdDoorPersoonAlsOuder(this.context, aanduidingKind, aanduidingOuder1, '1', adoptieOuderData);
    gegevenIsGeadopteerdDoorPersoonAlsOuder(this.context, aanduidingKind, aanduidingOuder2, '2', adoptieOuderData);
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