import { by } from 'protractor';
import { ApplicationFramePageObject } from '../common/application-frame.po';
import { LeftNavPageObject } from '../common/components/left-nav.po';

export class HomePageObject extends ApplicationFramePageObject {
  public readonly leftNav: LeftNavPageObject = new LeftNavPageObject(this.root);

  public async hasApplicationHeader(): Promise<boolean> {
    return this.root.element(by.css('ht-application-header')).isPresent();
  }

  public async hasAppContent(): Promise<boolean> {
    return this.root.element(by.css('.app-content')).isPresent();
  }
}
