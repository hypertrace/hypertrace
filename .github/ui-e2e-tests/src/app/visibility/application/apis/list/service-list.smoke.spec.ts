import { launch } from '../../../../launch';
import { expectNoSevereLogs, expectUrlContains } from '../../common/expectation-utils';

describe('Service List', () => {
  const navToServiceList = async () => launch().then(home => home.leftNav.clickOnServices());

  it('should display all components', async () => {
    const serviceList = await navToServiceList();
    expect(await serviceList.hasTableChart()).toBe(true, 'No table chart found in service list');
    expect(await serviceList.hasAtLeastOneRow()).toBe(true, 'No rows found in service list');
  });

  it('should navigate to service detail page', async () => {
    const serviceList = await navToServiceList();
    await serviceList.clickOnFirstServiceAndNavigate();
    await expectUrlContains('service/');
  });

  it('should navigate to api detail page', async () => {
    const serviceList = await navToServiceList();
    await serviceList.clickOnFirstServiceFirstApiAndNavigate();
    await expectUrlContains('endpoint/');
  });

  afterEach(async () => expectNoSevereLogs());
});
