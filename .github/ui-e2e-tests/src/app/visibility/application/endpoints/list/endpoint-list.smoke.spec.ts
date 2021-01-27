import { launch } from '../../../../launch';
import { expectNoSevereLogs, expectUrlContains } from '../../common/expectation-utils';

describe('Endpoint List', () => {
  const navToEndpointList = async () => launch().then(home => home.leftNav.clickOnApiEndpoints());

  it('should display all components', async () => {
    const endpointList = await navToEndpointList();
    expect(await endpointList.hasTableChart()).toBe(true, 'No table chart found in endpoints list');
    expect(await endpointList.hasAtLeastOneRow()).toBe(true, 'No rows found in endpoints list');
  });

  it('should navigate to endpoint detail page', async () => {
    const endpointList = await navToEndpointList();
    await endpointList.clickOnFirstEndpointAndNavigate();
    await expectUrlContains('endpoint/');
  });

  afterEach(async () => expectNoSevereLogs());
});