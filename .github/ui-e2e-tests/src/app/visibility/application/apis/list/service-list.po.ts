import { browser, by, ElementFinder } from 'protractor';
import { ApiOverviewPageObject } from '../../api-detail/overview/api-overview.po';
import { ApplicationFramePageObject } from '../../common/application-frame.po';
import { TablePageObject } from '../../common/components/table.po';
import { ServiceOverviewPageObject } from '../../service-detail/overview/service-overview.po';
import { ApisTabsPageObject } from '../apis-tabs.po';

export class ServiceListPageObject extends ApplicationFramePageObject {
  public readonly tabs: ApisTabsPageObject = new ApisTabsPageObject(this.root);
  private readonly table: TablePageObject = new TablePageObject(this.root);

  public async hasTableChart(): Promise<boolean> {
    return this.table.isVisible();
  }

  public async hasAtLeastOneRow(): Promise<boolean> {
    return this.table.hasAtLeastOneRow();
  }

  public async clickOnFirstServiceAndNavigate(): Promise<ServiceOverviewPageObject> {
    return this.findServiceWithApi(0)
      .then(cell => cell.element(by.css('ht-entity-renderer')).click())
      .then(() => new ServiceOverviewPageObject());
  }

  public async clickOnFirstServiceFirstApiAndNavigate(): Promise<ApiOverviewPageObject> {
    return this.findApiWithinService(0)
      .then(cell => cell.element(by.css('ht-entity-renderer')).click())
      .then(() => new ApiOverviewPageObject());
  }

  private async findApiWithinService(serviceRowIndex: number): Promise<ElementFinder> {
    return this.table
      .getCellAtIndex(serviceRowIndex, 0)
      .click()
      .then(() =>
        this.table
          .getCellAtIndex(serviceRowIndex + 1, 0)
          .element(by.css('ht-table-data-cell-renderer .expander-toggle'))
          .isPresent()
          .then(isExpanderIconCell => {
            if (!isExpanderIconCell) {
              // Is Api
              const apiCell = this.table.getCellAtIndex(serviceRowIndex + 1, 1);
              return new Promise<ElementFinder>(resolve => resolve(apiCell));
            } else {
              // Look in next row
              return this.findApiWithinService(serviceRowIndex + 1);
            }
          })
      );
  }

  private async findServiceWithApi(serviceRowIndex: number): Promise<ElementFinder> {
    return this.table
      .getCellAtIndex(serviceRowIndex, 0)
      .click()
      .then(() =>
        this.table
          .getCellAtIndex(serviceRowIndex + 1, 0)
          .element(by.css('ht-table-data-cell-renderer .expander-toggle'))
          .isPresent()
          .then(isExpanderIconCell => {
            if (!isExpanderIconCell) {
              // Service has Api
              const serviceCell = this.table.getCellAtIndex(serviceRowIndex, 1);
              return new Promise<ElementFinder>(resolve => resolve(serviceCell));
            } else {
              // Look in next row
              return this.findServiceWithApi(serviceRowIndex + 1);
            }
          })
      );
  }
}
