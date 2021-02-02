import { by } from 'protractor';
import { EndpointDetailPageObject } from '../endpoint-detail.po';

export class EndpointOverviewPageObject extends EndpointDetailPageObject {
  public async getMetricChartCount(): Promise<number> {
    return this.root.all(by.css('ht-metric-display-widget-renderer')).count();
  }

  public async hasCartesianChart(): Promise<boolean> {
    return this.root.all(by.css('ht-cartesian-chart')).isPresent();
  }

  public async hasTopologyChart(): Promise<boolean> {
    return this.root.all(by.css('ht-topology')).isPresent();
  }
}