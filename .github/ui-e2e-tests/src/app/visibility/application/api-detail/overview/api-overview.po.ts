import { by } from 'protractor';
import { ApiDetailPageObject } from '../api-detail.po';

export class ApiOverviewPageObject extends ApiDetailPageObject {
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
