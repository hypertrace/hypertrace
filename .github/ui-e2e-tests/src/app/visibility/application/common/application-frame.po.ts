import { by, element } from 'protractor';
import { BasePageObject } from './base.po';

export abstract class ApplicationFramePageObject extends BasePageObject {
  // No left nav in here to prevent circular refs
  public constructor() {
    super(element(by.css('ht-application-frame')));
  }

  public async hasApplicationHeader(): Promise<boolean> {
    return this.root.element(by.css('ht-application-header')).isPresent();
  }

  public async hasPageHeader(): Promise<boolean> {
    return this.root.element(by.css('ht-page-header')).isPresent();
  }

  public async hasAppContent(): Promise<boolean> {
    return this.root.element(by.css('.app-content')).isPresent();
  }
}
