#!/bin/bash

npx redocly bundle ./specificatie/referentie-data-api/openapi.yaml -o ./specificatie/referentie-data-api/resolved/openapi.yaml
npx redocly bundle ./specificatie/referentie-gezag-api/openapi.yaml -o ./specificatie/referentie-gezag-api/resolved/openapi.yaml
npx redocly bundle ./specificatie/referentie-gezag-api/openapi-v2.yaml -o ./specificatie/referentie-gezag-api/resolved/openapi-v2.yaml
npx redocly bundle ./specificatie/referentie-informatie-api/openapi.yaml -o ./specificatie/referentie-informatie-api/resolved/openapi.yaml
