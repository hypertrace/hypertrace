import { browser } from 'protractor';
import { HomePageObject } from './visibility/application/home/home.po';

export const launch = () =>
  browser.get(`${browser.baseUrl}?time=${browser.params.timeRange}`).then(() => new HomePageObject());
