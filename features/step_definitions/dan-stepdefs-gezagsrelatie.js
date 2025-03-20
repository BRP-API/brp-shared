const { Then } = require('@cucumber/cucumber');
const { createCollectieObjectMetSubCollectieObject,
        createCollectieObjectMetSubCollectieObjecten,
        createSubCollectieObjectInLastCollectieObject,
        createSubCollectieObjectenInLastCollectieObject,
        createSubSubCollectieObjectInLastSubCollectieObjectInLastCollectieObject,
        createSubSubCollectieObjectenInLastSubCollectieObjectInLastCollectieObject } = require('./dataTable2ObjectFactory');

function getPersoon(context, aanduiding) {
    return !aanduiding
        ? context.data.personen.at(-1)
        : context.data.personen.find(p => p.id === `persoon-${aanduiding}`);
}

function getPersoonBsn(context, aanduiding) {
    return getPersoon(context, aanduiding).persoon.at(-1).burger_service_nr;
}
        
Then(/^heeft de response een persoon met een 'gezag' met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObject(this.context, 'persoon', 'gezag', dataTable);
});

Then(/^heeft de persoon ?(?:nog)? een 'gezag' met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    createSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'gezag', dataTable);
});

Then(/^heeft ?(?:het)? 'gezag' ?(?:nog)? een '(\w*)' met de volgende gegevens$/, function (relatie, dataTable) {
    createSubSubCollectieObjectInLastSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'gezag', relatie, dataTable);
});

Then(/^heeft de response een persoon zonder gezag$/, function () {
    this.context.verifyResponse = true;

    createCollectieObjectMetSubCollectieObjecten(this.context, 'persoon', 'gezag');
});

Then(/^heeft de persoon geen gezag$/, function () {
    createSubCollectieObjectenInLastCollectieObject(this.context, 'persoon', 'gezag');
});

Then(/^heeft ?(?:het)? 'gezag' geen derden$/, function () {
    createSubSubCollectieObjectenInLastSubCollectieObjectInLastCollectieObject(this.context, 'persoon', 'gezag', 'derde');
});

function createDerde(context, aanduiding) {
    return !aanduiding
        ? { type: 'OnbekendeDerde' }
        : { type: 'BekendeDerde', burgerservicenummer: getPersoonBsn(context, aanduiding) };
}
function createPersoonMetGezag(context, type, aanduidingMinderjarige, aanduidingMeerderjarige1, aanduidingMeerderjarige2, toelichting = undefined) {
    let gezag = {
        type: type,
        minderjarige: {
            burgerservicenummer: getPersoonBsn(context, aanduidingMinderjarige)
        }
    };
    switch(type) {
        case 'gezamenlijk ouderlijk gezag':
            gezag.type = 'GezamenlijkOuderlijkGezag';
            gezag.ouders =[
                {
                    burgerservicenummer: getPersoonBsn(context, aanduidingMeerderjarige1)
                },
                {
                    burgerservicenummer: getPersoonBsn(context, aanduidingMeerderjarige2)
                }
            ];
            break;
        case 'eenhoofdig ouderlijk gezag':
            gezag.type = 'EenhoofdigOuderlijkGezag';
            gezag.ouder = {
                burgerservicenummer: getPersoonBsn(context, aanduidingMeerderjarige1)
            };
            break;
        case 'gezamenlijk gezag':
            gezag.type = 'GezamenlijkGezag';
            gezag.ouder = {
                burgerservicenummer: getPersoonBsn(context, aanduidingMeerderjarige1)
            },
            gezag.derde = createDerde(context, aanduidingMeerderjarige2);
            break;
        case 'voogdij':
            gezag.type = 'Voogdij';
            gezag.derden =[];
            if(aanduidingMeerderjarige1) {
                gezag.derden.push(createDerde(context, aanduidingMeerderjarige1));
            }
            break;
        case 'tijdelijk geen gezag':
            gezag.type = 'TijdelijkGeenGezag';
            gezag.toelichting = toelichting;
            break;
        case 'gezag niet te bepalen':
            gezag.type = 'GezagNietTeBepalen';
            gezag.toelichting = toelichting;
            break;
    }

    return persoon = {
        gezag: [gezag]
    };
}

Then(/^is het gezag over '(\w*)' (eenhoofdig ouderlijk gezag|gezamenlijk gezag) met ouder '(\w*)'(?: en een onbekende derde)?$/, function (aanduidingMinderjarige, type, aanduidingOuder) {
    this.context.verifyResponse = true;

    global.logger.info(`Dan is het gezag over '${aanduidingMinderjarige}' ${type} met ouder '${aanduidingOuder}'( en een onbekende derde)`);

    const expected = {
        personen: [ createPersoonMetGezag(this.context, type, aanduidingMinderjarige, aanduidingOuder) ]
    };

    this.context.expected = expected;
});

Then(/^is het gezag over '(\w*)' (gezamenlijk gezag|gezamenlijk ouderlijk gezag) met ouder '(\w*)' en (?:ouder|derde) '(\w*)'$/, function (aanduidingMinderjarige, type, aanduidingMeerderjarige1, aanduidingMeerderjarige2) {
    this.context.verifyResponse = true;

    global.logger.info(`Dan is het gezag over '${aanduidingMinderjarige}' ${type} met ouder '${aanduidingMeerderjarige1}' en derde '${aanduidingMeerderjarige2}'`);

    const expected = {
        personen: [ createPersoonMetGezag(this.context, type, aanduidingMinderjarige, aanduidingMeerderjarige1, aanduidingMeerderjarige2) ]
    };

    this.context.expected = expected;
});
       
Then(/^is het gezag over '(\w*)' voogdij(?: met derde '(\w*)')?$/, function (aanduidingMinderjarige, aanduidingMeerderjarige) {
    this.context.verifyResponse = true;

    global.logger.info(`Dan is het gezag over '${aanduidingMinderjarige}' voogdij (met derde '${aanduidingMeerderjarige}')`);

    const expected = {
        personen: [ createPersoonMetGezag(this.context, 'voogdij', aanduidingMinderjarige, aanduidingMeerderjarige, undefined) ]
    };

    this.context.expected = expected;
});

Then(/^is er tijdelijk geen gezag over '(\w*)' met de toelichting '([\w\. ]*)'$/, function (aanduidingMinderjarige, toelichting) {
    this.context.verifyResponse = true;

    global.logger.info(`Dan is er tijdelijk geen gezag over '${aanduidingMinderjarige}' met de toelichting '${toelichting}'`);

    const expected = {
        personen: [ createPersoonMetGezag(this.context, 'tijdelijk geen gezag', aanduidingMinderjarige, undefined, undefined, toelichting) ]
    };

    this.context.expected = expected;
});

Then(/^is het gezag over '(\w*)' niet te bepalen met de toelichting '([\w\. ]*)'$/, function (aanduidingMinderjarige, toelichting) {
    this.context.verifyResponse = true;

    global.logger.info(`Dan is het gezag over '${aanduidingMinderjarige}' niet te bepalen met de toelichting '${toelichting}'`);

    const expected = {
        personen: [ createPersoonMetGezag(this.context, 'gezag niet te bepalen', aanduidingMinderjarige, undefined, undefined, toelichting) ]
    };

    this.context.expected = expected;
});
