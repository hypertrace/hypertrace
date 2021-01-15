import { browser, logging } from 'protractor';

export const expectNoSevereLogs = async () => {
  // Assert that there are no errors emitted from the browser
  const logs = await browser.manage().logs().get(logging.Type.BROWSER);
  // Remove any errors from missing avatars
  const filteredLogs = logs.filter(log => !log.message.includes('gravatar.com'));

  expect(filteredLogs).not.toContain(
    jasmine.objectContaining({
      level: logging.Level.OFF
    })
  );
};

export const expectUrlContains = async (url: string) => {
  expect(await browser.getCurrentUrl()).toContain(url);
};
