
import { launch } from '../../../../../launch';
import { expectNoSevereLogs } from '../../../common/expectation-utils';

describe('Endpoint Overview', () => {
  it('should display all components', async () => {
    const endpointOverview = await launch()
      .then(page => page.leftNav.clickOnApiEndpoints())
      .then(page => page.clickOnFirstEndpointAndNavigate());

    expect(await endpointOverview.getActiveNavigableTabTitle()).toEqual('Overview');

    // Check all dashboard widgets to be present. This considers No data as an invalid state.
    expect(await endpointOverview.getMetricChartCount()).toEqual(6, 'Metric widgets missing on Endpoint overview');
    expect(await endpointOverview.hasCartesianChart()).toBeTruthy('Cartesian widget missing on Endpoint overview');
    expect(await endpointOverview.hasTopologyChart()).toBeTruthy('Topology missing on Endpoint overview');
  });

  afterEach(async () => expectNoSevereLogs());
});