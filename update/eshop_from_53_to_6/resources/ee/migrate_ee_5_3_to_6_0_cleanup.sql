/**
 * Copyright © OXID eSales AG. All rights reserved.
 * See LICENSE file for license details.
 */

/**
 YOU WILL LOSE DATA WHEN EXECUTING THESE QUERIES!

 Some functionality has been removed in OXID eShop version 6.0 and the data is no longer used by OXID eShop.
 As we cannot not know, if YOU still use the data in modules or 3rd party systems,
 please double check everything and comment the lines, if needed or if you have any doubts.
*/

/* The facebook functionality was moved to a module. */
ALTER TABLE `oxuser` DROP `OXFBID`;
DELETE FROM `oxconfig` WHERE OXVARNAME = 'blFacebookConfirmEnabled' AND (OXMODULE IS NULL OR OXMODULE = '');
DELETE FROM `oxcontents` WHERE `OXLOADID` = 'oxfacebookenableinfotext';

/*
 Tags functionality was moved to a module

 MySQL 5.5 users:
 In case you need to keep the OXTAGS fields, you need at least to DROP the FULLTEXT INDEX and to update the table engine.
 The business logic relies on the fact that all tables use engine InnoDB in order to run MySQL transactions.
 ALTER TABLE `oxartextends`
 DROP INDEX `OXTAGS`,
 DROP INDEX `OXTAGS_1`,
 DROP INDEX `OXTAGS_2`,
 DROP INDEX `OXTAGS_3`;
 ALTER TABLE `oxartextends` ENGINE = InnoDB;
*/
ALTER TABLE `oxartextends` DROP `OXTAGS`, DROP `OXTAGS_1`, DROP `OXTAGS_2`, DROP `OXTAGS_3`;
ALTER TABLE `oxartextends` ENGINE = InnoDB;
UPDATE `oxconfig` SET `OXVARVALUE` = 0x4dbace2972e14bf2cbd3a965143ee10209cf7c1ec96ab489d324f65ce48a4270f448eaf4f155a9ab5c73fe4e9a5ab491250a15931c5e20972e66c6bc28407f60159e035a97ccf914d874cd84268812ef4a515adeeb12ae33896e
WHERE `OXVARNAME` = 'aSearchCols' AND (OXMODULE IS NULL OR OXMODULE = '');
DELETE FROM `oxconfig` WHERE `OXVARNAME` = 'sTagSeparator' AND (OXMODULE IS NULL OR OXMODULE = '');
DELETE FROM `oxconfig` WHERE `OXVARNAME` = 'blShowTags' AND (OXMODULE IS NULL OR OXMODULE = '');
DELETE FROM `oxseo` WHERE OXSTDURL = 'index.php?cl=tags';

/* Guestbook functionality was moved to a module */
DROP TABLE IF EXISTS `oxgbentries`;
DELETE FROM `oxconfig` WHERE `OXVARNAME` = 'iMaxGBEntriesPerDay' AND (OXMODULE IS NULL OR OXMODULE = '');
DELETE FROM `oxconfig` WHERE `OXVARNAME` = 'blFooterShowGuestbook' AND (OXMODULE IS NULL OR OXMODULE = '');
DELETE FROM `oxconfigdisplay` WHERE `OXCFGMODULE` = 'blFooterShowGuestbook' AND (OXCFGMODULE = 'theme:flow' OR OXCFGMODULE = 'theme:azure');
DELETE FROM `oxseo` WHERE OXSTDURL = 'index.php?cl=guestbook';

/* Trusted Shops functionality was moved to a module */
ALTER TABLE `oxorder` DROP `OXTSPROTECTID`, DROP `OXTSPROTECTCOSTS`;
ALTER TABLE `oxpayments` DROP `OXTSPAYMENTID`;
DELETE FROM `oxcontents` WHERE `OXLOADID` = 'oxtsprotectiontext';
DELETE FROM `oxcontents` WHERE `OXLOADID` = 'oxtsinternationalfees';
DELETE FROM `oxcontents` WHERE `OXLOADID` = 'oxtscodmessage';

/* Statistics functionality was moved to a module */
DROP TABLE IF EXISTS `oxstatistics`;
DROP TABLE IF EXISTS `oxlogs`;

/* Captcha functionality was moved to a module */
DROP TABLE IF EXISTS `oxcaptcha`;

/* Delete stale config value */
DELETE FROM `oxconfig` WHERE `OXVARNAME` = "blLoadDynContents";

/* Delete old InvoicePDF template hook */
DELETE FROM `oxtplblocks` WHERE `OXMODULE` = 'invoicepdf';
