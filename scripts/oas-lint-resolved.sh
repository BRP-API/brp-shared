#!/bin/bash

npx --ignore-scripts redocly lint ./specificatie/referentie-data-api/resolved/openapi.yaml
npx --ignore-scripts redocly lint ./specificatie/referentie-informatie-api/resolved/openapi.yaml
npx --ignore-scripts redocly lint ./specificatie/referentie-gezag-api/resolved/openapi.yaml
npx --ignore-scripts redocly lint ./specificatie/referentie-gezag-api/resolved/openapi-v2.yaml
