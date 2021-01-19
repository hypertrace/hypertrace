import { by, ElementFinder } from 'protractor';
import { BasePageObject } from '../base.po';

export class MetricDisplayPageObject extends BasePageObject {
  public constructor(parent: ElementFinder) {
    super(parent.element(by.css('ht-metric-display')));
  }

  public async currentValue(): Promise<number> {
    return this.root.element(by.css('.value')).getText().then(parseInt);
  }
}
