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
        wijzigPersoon
      } = require('../persoon-2');
const { getAdresIndex,getPersoon } = require('../contextHelpers');
const { arrayOfArraysToDataTable } = require('../dataTableFactory');

defineParameterType({
  name: 'object soort',
  regexp: /(de |het |een )?(persoon|ouder 1|ouder 2|partner|kind|gezagsverhouding)/,
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

Given('heeft {object soort} met de volgende gegevens', function (soortPersoon, dataTable) {
  switch (soortPersoon) {
    case '1':
      createOuder(
        getPersoon(this.context, undefined),
        1,
        dataTable
      );
      break
    case '2':
      createOuder(
        getPersoon(this.context, undefined),
        2,
        dataTable
      );
      break
    case 'partner':
      createPartner(
        getPersoon(this.context, undefined),
        dataTable
      );
      break;
    case 'kind':
      createKind(
        getPersoon(this.context, undefined),
        dataTable
      );
      break;
    case 'gezagsverhouding':
      createGezagsverhouding(
        getPersoon(this.context, undefined),
        dataTable
      );
      break;
  }

  global.logger.info(`heeft ${soortPersoon} met de volgende gegevens`, getPersoon(this.context, undefined));
});

Given('{object soort} is {gewijzigd of gecorrigeerd} naar de volgende gegevens', function (soortPersoon, isCorrectie, dataTable) {
  switch (soortPersoon) {
    case 'persoon':
      wijzigPersoon(
        getPersoon(this.context, undefined),
        dataTable,
        isCorrectie
      );
      break;
    case '1':
      wijzigOuder(
        getPersoon(this.context, undefined),
        '1',
        dataTable,
        isCorrectie
      );
      break;
    case '2':
      wijzigOuder(
        getPersoon(this.context, undefined),
        '2',
        dataTable,
        isCorrectie
      );
      break;
    case 'partner':
      wijzigPartner(
        getPersoon(this.context, undefined),
        dataTable,
        isCorrectie
      );
      break;
    case 'kind':
      wijzigKind(
        getPersoon(this.context, undefined),
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

Given('is ingeschreven met de volgende gegevens', function (dataTable) {
  aanvullenInschrijving(
    getPersoon(this.context, undefined),
    dataTable
  );

  global.logger.info(`is ingeschreven met de volgende gegevens`, getPersoon(this.context, undefined));
});
