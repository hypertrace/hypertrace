import { launch } from '../../../../launch';
import { expectNoSevereLogs } from '../../common/expectation-utils';

describe('Service Overview', () => {
  it('should display all components', async () => {
    const serviceOverview = await launch()
      .then(page => page.leftNav.clickOnServices())
      .then(page => page.clickOnFirstServiceAndNavigate());

    expect(await serviceOverview.getActiveNavigableTabTitle()).toEqual('Overview');

    // Check all dashboard widgets to be present. This considers No data as an invalid state.
    expect(await serviceOverview.getMetricChartCount()).toEqual(
      6,
      'Unexpected count of metric charts on service overview'
    );
    expect(await serviceOverview.hasCartesianChart()).toBeTruthy('No cartesian chart present on service overview');
    expect(await serviceOverview.hasTopNChart()).toBeTruthy('No Top N chart present on service overview');
    expect(await serviceOverview.hasTopologyChart()).toBeTruthy('No topology present on service overview');
  });

  afterEach(async () => expectNoSevereLogs());
});
