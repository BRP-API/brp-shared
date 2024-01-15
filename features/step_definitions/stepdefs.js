const { World } = require('./world');
const { setWorldConstructor, setDefaultTimeout } = require('@cucumber/cucumber');

setWorldConstructor(World);

// https://github.com/cucumber/cucumber-js/blob/main/docs/support_files/timeouts.md
setDefaultTimeout(30000);

