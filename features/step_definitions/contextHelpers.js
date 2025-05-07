function getAdres(context, aanduiding) {
    return !aanduiding
        ? context.data.adressen.at(-1)
        : context.data.adressen.find(a => a.id === `adres-${aanduiding}`);
}

function getAdresIndex(context, aanduiding) {
    return context.data.adressen.findIndex(a => a.id === `adres-${aanduiding}`);
}

function getPersoon(context, aanduiding) {
    return !aanduiding
        ? context.data?.personen?.at(-1)
        : context.data?.personen?.find(p => p.id === `persoon-${aanduiding}`);
}

function getBsn(persoon) {
    return persoon.persoon.at(-1).burger_service_nr;
}

function getGeslachtsnaam(persoon) {
    return persoon.persoon.at(-1).geslachts_naam;
}

function getVoornamen(persoon) {
    return persoon.persoon.at(-1).voor_naam;
}

function getGeboortedatum(persoon) {
    return persoon.persoon.at(-1).geboorte_datum;
}

function getGeslachtsaanduiding(persoon) {
    return persoon.persoon.at(-1).geslachts_aand;
}

function getAkteNr(persoon) {
    return persoon.persoon.at(-1).akte_nr;
}

function getBeschrijvingDocument(persoon) {
    return persoon.persoon.at(-1).doc_beschrijving;
}

// converteert de properties van een persoon object naar een array van [name, value] arrays
// standaard worden de properties pl_id, stapel_nr, volg_nr en persoon_type uitgesloten
// extra properties kunnen worden uitgesloten door ze mee te geven in de extraPropertiestoExclude array
function persoonPropertiesToArrayofArrays(persoon, extraPropertiestoExclude = []) {
    const propertiesToExclude = ['pl_id', 'stapel_nr', 'volg_nr', 'persoon_type'].concat(extraPropertiestoExclude);

    const retval = [];

    if(persoon) {
        Object.keys(persoon.persoon.at(-1)).forEach(key => {
            if(!propertiesToExclude.includes(key)) {
                retval.push([key, persoon.persoon.at(-1)[key]]);
            }
        });
    }

    return retval;
}

module.exports = {
    getAdres,
    getAdresIndex,
    getAkteNr,
    getBeschrijvingDocument,
    getBsn,
    getVoornamen,
    getGeslachtsnaam,
    getGeboortedatum,
    getGeslachtsaanduiding,
    getPersoon,
    persoonPropertiesToArrayofArrays
};
