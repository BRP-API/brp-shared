#!/bin/bash

npx --ignore-scripts redocly lint ./specificatie/referentie-data-api/openapi.yaml
npx --ignore-scripts redocly lint ./specificatie/referentie-informatie-api/openapi.yaml
npx --ignore-scripts redocly lint ./specificatie/referentie-gezag-api/openapi.yaml
npx --ignore-scripts redocly lint ./specificatie/referentie-gezag-api/openapi-v2.yaml
