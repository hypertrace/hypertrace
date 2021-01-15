import { by, ElementFinder } from 'protractor';
import { ServiceListPageObject } from '../../apis/list/service-list.po';
import { ApplicationTopologyPageObject } from '../../apis/topology/application-topology.po';
import { BasePageObject } from '../base.po';

export class LeftNavPageObject extends BasePageObject {
  public constructor(parent: ElementFinder) {
    super(parent.element(by.css('.left-nav')));
  }

  public async clickOnApplicationFlow(): Promise<ApplicationTopologyPageObject> {
    return this.clickOnNavItem('Application Flow').then(() => new ApplicationTopologyPageObject());
  }

  public async clickOnServices(): Promise<ServiceListPageObject> {
    return this.clickOnNavItem('Services').then(() => new ServiceListPageObject());
  }

  private async clickOnNavItem(label: string): Promise<void> {
    return this.root.element(by.cssContainingText('.nav-item', label)).click();
  }
}
