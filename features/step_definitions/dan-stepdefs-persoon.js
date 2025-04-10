const { Then } = require('@cucumber/cucumber');
const { createCollectieObject,
        createCollectieObjectMetObjectVeld,
        createObjectVeldInLastCollectieObject } = require('./dataTable2ObjectFactory')
const { getBsn,
        getPersoon } = require('./contextHelpers');
    
Then(/^heeft de response ?(?:nog)? een persoon met ?(?:alleen)? de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    createCollectieObject(this.context, 'persoon', dataTable);
});

Then(/^heeft de response een persoon zonder gegevens$/, function () {
    this.context.verifyResponse = true;

    createCollectieObject(this.context, 'persoon');
});

Then(/^heeft de response een persoon met ?(?:alleen)? de volgende '(\w*)' gegevens$/, function (naamObjectProperty, dataTable) {
    this.context.verifyResponse = true;

    createCollectieObjectMetObjectVeld(this.context, 'persoon', naamObjectProperty, dataTable);
});

Then(/^heeft de response een persoon zonder '(\w*)' gegevens$/, function (naamSubCollectieObject) {
    this.context.verifyResponse = true;

    createCollectieObjectMetObjectVeld(this.context, 'persoon', naamSubCollectieObject);   
});

Then(/^heeft de persoon ?(?:alleen)? de volgende '(\w*)' gegevens$/, function (naamObjectProperty, dataTable) {
    createObjectVeldInLastCollectieObject(this.context, 'persoon', naamObjectProperty, dataTable);
});

Then(/^heeft de persoon geen '(\w*)' gegevens$/, function (naamSubCollectieObject) {
    createObjectVeldInLastCollectieObject(this.context, 'persoon', naamSubCollectieObject);
});

function setProperty(obj, key, value) {
    if(value) {
        if(!obj) {
            obj = {};
        }
        obj[key] = value;
    }
}

Then('wordt/worden (alleen ){aanduidingen} gevonden', function(persoonAanduidingen) {
    this.context.verifyResponse = true;

    const expected = { personen: [] };

    for(const persoonAanduiding of persoonAanduidingen) {
        const persoon = getPersoon(this.context, persoonAanduiding);

        let target = {};

        setProperty(target, 'burgerservicenummer', getBsn(persoon));

        expected.personen.push(target);
    }

    this.context.expected = expected;
});
