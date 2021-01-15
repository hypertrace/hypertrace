import { by, ElementFinder } from 'protractor';
import { BasePageObject } from '../base.po';

export class TablePageObject extends BasePageObject {
  public constructor(parent: ElementFinder) {
    super(parent.element(by.css('ht-table')));
  }

  public getRowAtIndex(index: number): ElementFinder {
    return this.root.all(by.css('ht-table cdk-row')).get(index);
  }

  public getCellAtIndex(rowIndex: number, cellIndex: number): ElementFinder {
    return this.getRowAtIndex(rowIndex).all(by.css('cdk-cell')).get(cellIndex);
  }

  public async hasAtLeastOneRow(): Promise<boolean> {
    return this.getRowAtIndex(0).isPresent();
  }
}
