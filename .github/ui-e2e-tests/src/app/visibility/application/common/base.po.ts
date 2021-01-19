import { ElementFinder } from 'protractor';

export abstract class BasePageObject {
  protected constructor(protected readonly root: ElementFinder) {}

  public async isVisible(): Promise<boolean> {
    return this.root.isDisplayed();
  }
}
