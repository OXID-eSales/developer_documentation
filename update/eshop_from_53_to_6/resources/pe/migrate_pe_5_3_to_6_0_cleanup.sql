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

/* Unify shop IDs. The new default shop ID is 1. If you somehow changed the shop ID, you should adjust this queries! */
UPDATE `oxacceptedterms` SET `OXSHOPID` = 1;
UPDATE `oxactions` SET `OXSHOPID` = 1;
UPDATE `oxactions2article` SET `OXSHOPID` = 1;
UPDATE `oxarticles` SET `OXSHOPID` = 1;
UPDATE `oxattribute` SET `OXSHOPID` = 1;
UPDATE `oxcategories` SET `OXSHOPID` = 1;
UPDATE `oxconfig` SET `OXSHOPID` = 1;
UPDATE `oxcontents` SET `OXSHOPID` = 1;
UPDATE `oxdelivery` SET `OXSHOPID` = 1;
UPDATE `oxdeliveryset` SET `OXSHOPID` = 1;
UPDATE `oxdiscount` SET `OXSHOPID` = 1;
UPDATE `oxlinks` SET `OXSHOPID` = 1;
UPDATE `oxmanufacturers` SET `OXSHOPID` = 1;
UPDATE `oxnews` SET `OXSHOPID` = 1;
UPDATE `oxnewsletter` SET `OXSHOPID` = 1;
UPDATE `oxnewssubscribed` SET `OXSHOPID` = 1;
UPDATE `oxobject2group` SET `OXSHOPID` = 1;
UPDATE `oxobject2seodata` SET `OXSHOPID` = 1;
UPDATE `oxorder` SET `OXSHOPID` = 1;
UPDATE `oxorderarticles` SET `OXORDERSHOPID` = 1;
UPDATE `oxorderfiles` SET `OXSHOPID` = 1;
UPDATE `oxprice2article` SET `OXSHOPID` = 1;
UPDATE `oxpricealarm` SET `OXSHOPID` = 1;
UPDATE `oxratings` SET `OXSHOPID` = 1;
UPDATE `oxrecommlists` SET `OXSHOPID` = 1;
UPDATE `oxselectlist` SET `OXSHOPID` = 1;
UPDATE `oxseo` SET `OXSHOPID` = 1;
UPDATE `oxseohistory` SET `OXSHOPID` = 1;
UPDATE `oxseologs` SET `OXSHOPID` = 1;
UPDATE `oxshops` SET `OXID` = 1;
UPDATE `oxtplblocks` SET `OXSHOPID` = 1;
UPDATE `oxuser` SET `OXSHOPID` = 1;
UPDATE `oxvendor` SET `OXSHOPID` = 1;
UPDATE `oxvoucherseries` SET `OXSHOPID` = 1;
UPDATE `oxwrapping` SET `OXSHOPID` = 1;

ALTER TABLE `oxacceptedterms` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxactions` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxactions2article` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxarticles` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxattribute` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxcategories` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxconfig` modify `OXSHOPID` int(11) NOT NULL DEFAULT '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxcontents` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxdelivery` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxdeliveryset` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxdiscount` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxlinks` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxmanufacturers` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxnews` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxnewsletter` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxnewssubscribed` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxobject2group` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxobject2seodata` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxorder` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxorderarticles` modify `OXORDERSHOPID` int(11) NOT NULL default 1 COMMENT 'Shop id (oxshops), in which order was done';
ALTER TABLE `oxorderfiles` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxprice2article` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxpricealarm` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxratings` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxrecommlists` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxselectlist` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxseo` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxseohistory` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxseologs` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxshops` CHANGE `OXID` `OXID` int(11) NOT NULL default '1' COMMENT 'Shop id';
ALTER TABLE `oxtplblocks` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxuser` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxvendor` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxvoucherseries` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';
ALTER TABLE `oxwrapping` modify `OXSHOPID` int(11) NOT NULL default '1' COMMENT 'Shop id (oxshops)';

/* Facebook functionality was moved to a module */
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
