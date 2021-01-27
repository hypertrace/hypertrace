import { by } from 'protractor';
import { ApplicationFramePageObject } from '../../common/application-frame.po';
import { TablePageObject } from '../../common/components/table.po';
import { EndpointOverviewPageObject } from '../endpoint-detail/overview/endpoint-overview.po';

export class EndpointListPageObject extends ApplicationFramePageObject {
  private readonly table: TablePageObject = new TablePageObject(this.root);

  public async hasTableChart(): Promise<boolean> {
    return this.table.isVisible();
  }

  public async hasAtLeastOneRow(): Promise<boolean> {
    return this.table.hasAtLeastOneRow();
  }

  public async clickOnFirstEndpointAndNavigate(): Promise<EndpointOverviewPageObject> {
    return this.table
      .getCellAtIndex(0, 0)
      .element(by.css('ht-entity-renderer'))
      .click()
      .then(() => new EndpointOverviewPageObject());
  }
}