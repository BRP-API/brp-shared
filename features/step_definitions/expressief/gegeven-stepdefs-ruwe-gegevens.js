const { Given, defineParameterType } = require('@cucumber/cucumber');
const { 
        createOuder, wijzigOuder, 
        createPartner, wijzigPartner, 
        aanvullenInschrijving,
        createVerblijfplaats, wijzigVerblijfplaats, 
        createKind, wijzigKind, 
        createOverlijden,
        createGezagsverhouding,
        wijzigGezagsverhouding,
        wijzigPersoon,
        createOuderMetAanduiding,
        wijzigOuderMetAanduiding,
        createPartnerMetAanduiding,
        wijzigPartnerMetAanduiding,
        createKindMetAanduiding,
        wijzigKindMetAanduiding
      } = require('../persoon-2');
const { getAdresIndex,getPersoon } = require('../contextHelpers');
const { arrayOfArraysToDataTable } = require('../dataTableFactory');

defineParameterType({
  name: 'object soort',
  regexp: /(de |het |een )?(ouder 1|ouder 2|partner|kind|gezagsverhouding)/,
  transformer(lidwoord, soortPersoon) {
    return soortPersoon.split(' ').at(-1)
  }
});

defineParameterType({
    name: 'gewijzigd of gecorrigeerd',
    regexp: /(gewijzigd|gecorrigeerd)/,
    transformer(soortMutatie) {
        return soortMutatie=='gecorrigeerd';
    }
});

Given('heeft {object soort} {aanduiding} met de volgende gegevens', function (soortPersoon, relatieAanduiding, dataTable) {
  switch (soortPersoon) {
    case '1':
    case '2':
      createOuderMetAanduiding(
        getPersoon(this.context, undefined),
        soortPersoon,
        relatieAanduiding,
        dataTable
      );
      break;
    case 'partner':
      createPartnerMetAanduiding(
        getPersoon(this.context, undefined),
        relatieAanduiding,
        dataTable
      );
      break;
    case 'kind':
      createKindMetAanduiding(
        getPersoon(this.context, undefined),
        relatieAanduiding,
        dataTable
      );
      break;
  }
});

Given('{object soort} {aanduiding} is {gewijzigd of gecorrigeerd} naar de volgende gegevens', function (soortPersoon, relatieAanduiding, isCorrectie, dataTable) {
  switch (soortPersoon) {
    case '1':
    case '2':
      wijzigOuderMetAanduiding(
        getPersoon(this.context, undefined),
        soortPersoon,
        relatieAanduiding,
        dataTable,
        isCorrectie
      );
      break;
    case 'partner':
      wijzigPartnerMetAanduiding(
        getPersoon(this.context, undefined),
        relatieAanduiding,
        dataTable,
        isCorrectie
      );
      break;
    case 'kind':
      wijzigKindMetAanduiding(
        getPersoon(this.context, undefined),
        relatieAanduiding,
        dataTable,
        isCorrectie
      );
      break;
    case 'gezagsverhouding':
      wijzigGezagsverhouding(
        getPersoon(this.context, undefined),
        dataTable,
        isCorrectie
      );
      break;
  }

  global.logger.info(`${soortPersoon} is gewijzigd/gecorrigeerd naar de volgende gegevens`, getPersoon(this.context, undefined));
});

function inschrijvingOpVerblijfplaats(context, dataTable) {
  let persoon = getPersoon(context, undefined)

  if (!persoon.verblijfplaats) {
    createVerblijfplaats(
      persoon,
      dataTable
    );
  } else {
    wijzigVerblijfplaats(
      persoon,
      dataTable
    );
  }
}

Given('is ingeschreven op adres {string} met de volgende gegevens', function (adresAanduiding, dataTable) {
  const data = [
    ['adres_id', getAdresIndex(this.context, adresAanduiding) + '']
  ];

  inschrijvingOpVerblijfplaats(this.context, arrayOfArraysToDataTable(data, dataTable));

  global.logger.info(`is ingeschreven op adres ${adresAanduiding} met de volgende gegevens`, getPersoon(this.context, undefined));
});

Given('is ingeschreven op een buitenlands adres met de volgende gegevens', function (dataTable) {
  inschrijvingOpVerblijfplaats(this.context, dataTable)

  global.logger.info(`is ingeschreven op de buitenlandse verblijfplaats met de volgende gegevens`, getPersoon(this.context, undefined));
});

Given('is overleden met de volgende gegevens', function (dataTable) {
  createOverlijden(
    getPersoon(this.context, undefined),
    dataTable
  );

  global.logger.info(`is overleden met de volgende gegevens`, getPersoon(this.context, undefined));
});

Given('is ingeschreven met de volgende gegevens', function (dataTable) {
  aanvullenInschrijving(
    getPersoon(this.context, undefined),
    dataTable
  );

  global.logger.info(`is ingeschreven met de volgende gegevens`, getPersoon(this.context, undefined));
});

Given('heeft de volgende gezagsverhouding gegevens', function (dataTable) {
      createGezagsverhouding(
        getPersoon(this.context, undefined),
        dataTable
      );
});
