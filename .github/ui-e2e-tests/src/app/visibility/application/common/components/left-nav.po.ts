import { by, ElementFinder } from 'protractor';
import { EndpointListPageObject } from '../../endpoints/list/endpoint-list.po';
import { ServiceListPageObject } from '../../services/service-list.po';
import { ApplicationTopologyPageObject } from '../../topology/application-topology.po';
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


  public async clickOnApiEndpoints(): Promise<EndpointListPageObject> {
    return this.clickOnNavItem('API Endpoints').then(() => new EndpointListPageObject());
  }

  private async clickOnNavItem(label: string): Promise<void> {
    return this.root.element(by.cssContainingText('.nav-item', label)).click();
  }
}
