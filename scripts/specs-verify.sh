#!/bin/bash

npx cucumber-js -f json:./test-reports/cucumber-js/test-result-zonder-dependency-integratie.json \
                -f summary:./test-reports/cucumber-js/test-result-zonder-dependency-integratie-summary.txt \
                -f summary \
                --tags "not @integratie"
