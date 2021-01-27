import { by } from 'protractor';
import { ApplicationFramePageObject } from '../common/application-frame.po';

export class ApplicationTopologyPageObject extends ApplicationFramePageObject {

  public async hasTopologyChart(): Promise<boolean> {
    return this.root.element(by.css('ht-topology')).isPresent();
  }

  public async hasTopologyEdges(): Promise<boolean> {
    return this.root.element(by.css('.entity-edge')).isPresent();
  }

  public async hasTopologyNodes(): Promise<boolean> {
    return this.root.element(by.css('.entity-node')).isPresent();
  }
}
