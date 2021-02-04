import { by } from 'protractor';
import { ApplicationFramePageObject } from '../common/application-frame.po';
import { TablePageObject } from '../common/components/table.po';
import { ServiceOverviewPageObject } from './service-detail/overview/service-overview.po';

export class ServiceListPageObject extends ApplicationFramePageObject {
  private readonly table: TablePageObject = new TablePageObject(this.root);

  public async hasTableChart(): Promise<boolean> {
    return this.table.isVisible();
  }

  public async hasAtLeastOneRow(): Promise<boolean> {
    return this.table.hasAtLeastOneRow();
  }

  public async clickOnFirstServiceAndNavigate(): Promise<ServiceOverviewPageObject> {
    return this.table
      .getCellAtIndex(0, 0)
      .element(by.css('ht-entity-renderer'))
      .click()
      .then(() => new ServiceOverviewPageObject());
  }
}