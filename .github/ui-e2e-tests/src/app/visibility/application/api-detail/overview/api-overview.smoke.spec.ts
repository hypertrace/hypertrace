import { launch } from '../../../../launch';
import { expectNoSevereLogs } from '../../common/expectation-utils';

describe('Api Overview', () => {
  it('should display all components', async () => {
    const apiOverview = await launch()
      .then(page => page.leftNav.clickOnServices())
      .then(page => page.clickOnFirstServiceFirstApiAndNavigate());

    expect(await apiOverview.getActiveNavigableTabTitle()).toEqual('Overview');

    // Check all dashboard widgets to be present. This considers No data as an invalid state.
    expect(await apiOverview.getMetricChartCount()).toEqual(6, 'Metric widgets missing on api overview');
    expect(await apiOverview.hasCartesianChart()).toBeTruthy('Cartesian widget missing on API overview');
    expect(await apiOverview.hasTopologyChart()).toBeTruthy('Topology missing on API overview');
  });

  afterEach(async () => expectNoSevereLogs());
});
