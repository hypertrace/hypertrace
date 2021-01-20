const { SpecReporter } = require('jasmine-spec-reporter');
const { logging } = require('selenium-webdriver');

exports.config = {
  allScriptsTimeout: 11000,
  capabilities: {
    browserName: 'chrome',
    'goog:chromeOptions': {
      args: ['--headless', '--disable-gpu', '--window-size=1280,800']
    }
  },
  directConnect: true,
  baseUrl: 'http://localhost:2020',
  framework: 'jasmine',
  suites: {
    smoke: './src/**/*.smoke.spec.ts'
  },
  params: {
    timeRange: '2w' 
  },
  jasmineNodeOpts: {
    showColors: true,
    defaultTimeoutInterval: 30000,
    print: function () {}
  },
  onPrepare: async () => {
    require('ts-node').register({
      project: require('path').join(__dirname, './tsconfig.json')
    });
    jasmine.getEnv().addReporter(new SpecReporter({ spec: { displayStacktrace: true } }));
    const config = await browser.getProcessedConfig();
    const url = browser.driver
      .get(config.baseUrl)
      .then(() => new Promise(resolve => setTimeout(() => resolve(), 2000)))
      .then(() => browser.manage().logs().get(logging.Type.BROWSER));

    return await browser.driver.wait(url, 20000);
  }
};
