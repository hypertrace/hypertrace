import { by } from 'protractor';
import { ServiceDetailPageObject } from '../service-detail.po';

export class ServiceOverviewPageObject extends ServiceDetailPageObject {
  public async getMetricChartCount(): Promise<number> {
    return this.root.all(by.css('ht-metric-display-widget-renderer')).count();
  }

  public async hasCartesianChart(): Promise<boolean> {
    return this.root.element(by.css('ht-cartesian-chart')).isPresent();
  }

  public async hasTopNChart(): Promise<boolean> {
    return this.root.element(by.css('ht-gauge-list')).isPresent();
  }

  public async hasTopologyChart(): Promise<boolean> {
    return this.root.element(by.css('ht-topology')).isPresent();
  }
}
