const { When } = require('@cucumber/cucumber');
const fs = require('fs');
const { executeSqlStatements } = require('./postgresqlHelpers');
const { execute } = require('./postgresqlHelpers-2');
const { generateSqlStatementsFrom } = require('./sqlStatementsFactory');
const { objectToDataTable } = require('./dataTableFactory');

const { addDefaultAutorisatieSettings,
        handleRequest } = require('./requestHelpers');

function initializeAfnemerIdAndGemeenteCode(context) {
    if(context.afnemerID === undefined) {
        context.afnemerID = context.oAuth.clients[0].afnemerID;
        context.gemeenteCode = context.oAuth.clients[0].gemeenteCode;
    }
}

function mapEndpointToRelativeUrl(context, endpoint) {
    return context.apiEndpointPrefixMap.has(endpoint)
        ? `${context.apiEndpointPrefixMap.get(endpoint)}/${endpoint}`
        : '';
}

async function execSqlStatements(context) {
    if(context.sqlData === undefined) {
        context.sqlData = [{}];
    }

    if(context.data) {
        await execute(generateSqlStatementsFrom(context.data));
    }
    else {
        await executeSqlStatements(context.sql, context.sqlData, global.pool);
    }
}

function createDataTableFromRequestbodyData(parameterNames, fields) {
    let requestBody;
    switch(parameterNames) {
        case 'burgerservicenummer':
            requestBody = {
                type: 'RaadpleegMetBurgerservicenummer',
                burgerservicenummer: '000000001'
            };
            break;
        case 'adresseerbaar object identificatie':
            requestBody = {
                type: 'ZoekMetAdresseerbaarObjectIdentificatie',
                adresseerbaarObjectIdentificatie: '0000000000000001'
            };
            break;
        case 'geslachtsnaam en geboortedatum':
            requestBody = {
                type: 'ZoekMetGeslachtsnaamEnGeboortedatum',
                geslachtsnaam: 'doe',
                geboortedatum: '2000-01-01'
            };
            break;
        case 'geslachtsnaam, voornamen en gemeente van inschrijving':
            requestBody = {
                type: 'ZoekMetNaamEnGemeenteVanInschrijving',
                geslachtsnaam: 'doe',
                voornamen: 'john',
                gemeenteVanInschrijving: '0000'
            };
            break;
        case 'nummeraanduiding identificatie':
            requestBody = {
                type: 'ZoekMetNummeraanduidingIdentificatie',
                nummeraanduidingIdentificatie: '0000000000000001'
            };
            break;
        case 'postcode en huisnummer':
            requestBody = {
                type: 'ZoekMetPostcodeEnHuisnummer',
                postcode: '1000 AA',
                huisnummer: '1'
            };
            break;
        case 'straatnaam, huisnummer en gemeente van inschrijving':
            requestBody = {
                type: 'ZoekMetStraatHuisnummerEnGemeenteVanInschrijving',
                straat: 'straat',
                huisnummer: '1',
                gemeenteVanInschrijving: '0000'
            };
            break;
        default:
            break;
    }
    if(fields) {
        requestBody.fields = fields;
    }

    return objectToDataTable(requestBody);
}
        
When(/^([a-zA-Z-]*) wordt gezocht met de volgende parameters$/, async function (endpoint, dataTable) {
    initializeAfnemerIdAndGemeenteCode(this.context);

    if(this.context.gezag !== undefined) {
        fs.writeFileSync(this.context.gezagDataPath, JSON.stringify(this.context.gezag, null, '\t'));
    }
    if(this.context.downstreamApiResponseHeaders !== undefined) {
        fs.writeFileSync(this.context.downstreamApiDataPath + '/response-headers.json',
                         JSON.stringify(this.context.downstreamApiResponseHeaders[0], null, '\t'));
    }
    if(this.context.downstreamApiResponseBody !== undefined) {
        fs.writeFileSync(this.context.downstreamApiDataPath + '/response-body.json',
                         this.context.downstreamApiResponseBody);
    }

    addDefaultAutorisatieSettings(this.context, this.context.afnemerID);

    await execSqlStatements(this.context);

    const relativeUrl = mapEndpointToRelativeUrl(this.context, endpoint);

    await handleRequest(this.context, relativeUrl, dataTable);
});

When(/^([a-zA-Z-]*) wordt gezocht met een '(\w*)' aanroep$/, async function (endpoint, httpMethod) {
    initializeAfnemerIdAndGemeenteCode(this.context);

    const relativeUrl = mapEndpointToRelativeUrl(this.context, endpoint);

    await handleRequest(this.context, relativeUrl, undefined, httpMethod);
});

When(/^het '([a-zA-Z0-9\.]*)' veld wordt gevraagd van personen gezocht met ([a-zA-Z, ]*)$/, async function (fields, parameterNames) {
    initializeAfnemerIdAndGemeenteCode(this.context);

    const endpoint = 'personen';
    const dataTable = createDataTableFromRequestbodyData(parameterNames, fields);

    const relativeUrl = mapEndpointToRelativeUrl(this.context, endpoint);

    addDefaultAutorisatieSettings(this.context, this.context.afnemerID);

    await execSqlStatements(this.context);

    await handleRequest(this.context, relativeUrl, dataTable);
});
