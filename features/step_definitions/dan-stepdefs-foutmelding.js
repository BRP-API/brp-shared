const { Then } = require('@cucumber/cucumber');
const { createVelden,
        createCollectieObject } = require('./dataTable2ObjectFactory')

Then(/^heeft de response geen foutmelding$/, function () {});

Then(/^heeft de response een foutmelding$/, function (dataTable) {
    this.context.verifyResponse = true;

    createVelden(this.context, dataTable);
});

Then(/^de volgende invalidParams foutmeldingen$/, function (dataTable) {
    createCollectieObject(this.context, 'invalidParams', dataTable);
});
