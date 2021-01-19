import { by } from 'protractor';
import { BasePageObject } from '../common/base.po';
import { ServiceListPageObject } from './list/service-list.po';

export class ApisTabsPageObject extends BasePageObject {
  public async getActiveNavigableTabTitle(): Promise<string> {
    return this.root.element(by.css('ht-navigable-tab-group .mat-tab-label-active')).getText();
  }

  private async clickOnTabWithText(label: string): Promise<void> {
    return this.root.element(by.cssContainingText('ht-navigable-tab-group .tab-link', label)).click();
  }
}
