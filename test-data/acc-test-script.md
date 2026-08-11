# Testen van de BRP API services in ACC

In dit bestand staan curl statements die voor test doeleinden kunnen worden gebruikt om requests te sturen naar de BRP API endpoints.

## Authenticeren bij de Identity Provider

Gebruik onderstaand curl statement om te worden geauthenticeerd door de Identity Provider.
Bij correct authenticatie bevat de response een access token die moet worden toegevoegd aan de requests naar de BRP API services

curl --location --request POST '[token endpoint van identity provider]' \
--header 'content-type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=client_credentials' \
--data-urlencode 'client_id=[client_id]' \
--data-urlencode 'client_secret=[client_secret]' \
--data-urlencode 'scope=000000099000000080000' \
--data-urlencode 'resourceServer=ResourceServer02'

## (400) Bad Requests naar de verblijfplaatshistorie endpoint

curl --location --request POST '[acc domeinnaam]/haalcentraal/api/brphistorie/verblijfplaatshistorie' \
--header 'Authorization: Bearer [access token verkregen via bovenstaande aanroep]' \
--header 'content-type: application/json' \
--data '{"type": "RaadpleegMetPeildatum", "burgerservicenummer": "000000012"}'

Verwachte response:

{"type":"https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1","title":"Een of meerdere parameters zijn niet correct.","status":400,"detail":"De foutieve parameter(s) zijn: peildatum.","instance":"/haalcentraal/api/brphistorie/verblijfplaatshistorie","code":"paramsValidation","invalidParams":[{"name":"peildatum","code":"required","reason":"Parameter is verplicht."}]}


## (200) Succesvolle Requests naar de verblijfplaatshistorie endpoint

curl --location --request POST '[acc domeinnaam]/haalcentraal/api/brphistorie/verblijfplaatshistorie' \
--header 'Authorization: Bearer [access token verkregen via bovenstaande aanroep]' \
--header 'content-type: application/json' \
--data '{"type": "RaadpleegMetPeildatum", "burgerservicenummer": "000000012", "peildatum": "2024-01-01"}'

Verwachte response:

{"verblijfplaatsen":[{...}]}
