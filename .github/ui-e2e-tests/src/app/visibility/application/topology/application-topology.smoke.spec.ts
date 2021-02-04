import { launch } from '../../../launch';
import { expectNoSevereLogs } from '../common/expectation-utils';

describe('Application Topology', () => {
  it('should display all components', async () => {
    const home = await launch();
    const topology = await home.leftNav.clickOnApplicationFlow();

    expect(await topology.hasTopologyChart()).toBeTruthy('Topology widget missing on application flow');
    expect(await topology.hasTopologyEdges()).toBeTruthy('No edges visible on application flow');
    expect(await topology.hasTopologyNodes()).toBeTruthy('No nodes visible on application flow');
  });

  afterEach(async () => {
    await expectNoSevereLogs();
  });
});
