import { launch } from '../../../launch';
import { expectNoSevereLogs } from '../common/expectation-utils';

describe('Home page', () => {
  it('should display application frame', async () => {
    const home = await launch();
    expect(await home.hasApplicationHeader()).toBeTruthy();
    expect(await home.leftNav.isVisible()).toBeTruthy();
    expect(await home.hasAppContent()).toBeTruthy();
  });

  afterEach(async () => {
    await expectNoSevereLogs();
  });
});
