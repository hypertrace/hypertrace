import { by } from 'protractor';
import { ApplicationFramePageObject } from '../common/application-frame.po';

export abstract class ServiceDetailPageObject extends ApplicationFramePageObject {
  public async getActiveNavigableTabTitle(): Promise<string> {
    return this.root.element(by.css('ht-navigable-tab-group .mat-tab-label-active')).getText();
  }
}
