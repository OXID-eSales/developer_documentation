/*!40101 SET character_set_client = utf8 */;

UPDATE oxshops SET OXVERSION = '6.0.0', OXNAME = 'OXID eShop 6';


/*
 Add explicit sorting to the table `oxdiscount`
 Important note: this migration must run prior the change of the storage engine to InnoDB
*/
ALTER TABLE `oxdiscount` ADD COLUMN `OXSORT` INT(5) NOT NULL DEFAULT '0' COMMENT 'Defines the order discounts are applied to basket or product' AFTER `OXITMMULTIPLE`;
UPDATE `oxdiscount` CROSS JOIN (SELECT @rownumber := 0) r SET `oxdiscount`.`OXSORT` = (@rownumber := @rownumber + 10);
ALTER TABLE `oxdiscount` ADD UNIQUE INDEX `UNIQ_OXSORT` (`OXSHOPID`, `OXSORT`);


/* Change storage engine for all tables to InnoDB */
ALTER TABLE oxacceptedterms         ENGINE = InnoDB;
ALTER TABLE oxaccessoire2article    ENGINE = InnoDB;
ALTER TABLE oxactions               ENGINE = InnoDB;
ALTER TABLE oxactions2article       ENGINE = InnoDB;
ALTER TABLE oxaddress               ENGINE = InnoDB;
ALTER TABLE oxadminlog              ENGINE = InnoDB;
ALTER TABLE oxattribute             ENGINE = InnoDB;
ALTER TABLE oxcategories            ENGINE = InnoDB;
ALTER TABLE oxcategory2attribute    ENGINE = InnoDB;
ALTER TABLE oxconfig                ENGINE = InnoDB;
ALTER TABLE oxconfigdisplay         ENGINE = InnoDB;
ALTER TABLE oxcontents              ENGINE = InnoDB;
ALTER TABLE oxcountry               ENGINE = InnoDB;
ALTER TABLE oxdel2delset            ENGINE = InnoDB;
ALTER TABLE oxdelivery              ENGINE = InnoDB;
ALTER TABLE oxdeliveryset           ENGINE = InnoDB;
ALTER TABLE oxdiscount              ENGINE = InnoDB;
ALTER TABLE oxfiles                 ENGINE = InnoDB;
ALTER TABLE oxgroups                ENGINE = InnoDB;
ALTER TABLE oxinvitations           ENGINE = InnoDB;
ALTER TABLE oxlinks                 ENGINE = InnoDB;
ALTER TABLE oxmanufacturers         ENGINE = InnoDB;
ALTER TABLE oxmediaurls             ENGINE = InnoDB;
ALTER TABLE oxnews                  ENGINE = InnoDB;
ALTER TABLE oxnewsletter            ENGINE = InnoDB;
ALTER TABLE oxnewssubscribed        ENGINE = InnoDB;
ALTER TABLE oxobject2action         ENGINE = InnoDB;
ALTER TABLE oxobject2article        ENGINE = InnoDB;
ALTER TABLE oxobject2attribute      ENGINE = InnoDB;
ALTER TABLE oxobject2category       ENGINE = InnoDB;
ALTER TABLE oxobject2delivery       ENGINE = InnoDB;
ALTER TABLE oxobject2discount       ENGINE = InnoDB;
ALTER TABLE oxobject2group          ENGINE = InnoDB;
ALTER TABLE oxobject2list           ENGINE = InnoDB;
ALTER TABLE oxobject2payment        ENGINE = InnoDB;
ALTER TABLE oxobject2selectlist     ENGINE = InnoDB;
ALTER TABLE oxobject2seodata        ENGINE = InnoDB;
ALTER TABLE oxpayments              ENGINE = InnoDB;
ALTER TABLE oxprice2article         ENGINE = InnoDB;
ALTER TABLE oxpricealarm            ENGINE = InnoDB;
ALTER TABLE oxratings               ENGINE = InnoDB;
ALTER TABLE oxrecommlists           ENGINE = InnoDB;
ALTER TABLE oxremark                ENGINE = InnoDB;
ALTER TABLE oxreviews               ENGINE = InnoDB;
ALTER TABLE oxselectlist            ENGINE = InnoDB;
ALTER TABLE oxshops                 ENGINE = InnoDB;
ALTER TABLE oxstates                ENGINE = InnoDB;
ALTER TABLE oxtplblocks             ENGINE = InnoDB;
ALTER TABLE oxuser                  ENGINE = InnoDB;
ALTER TABLE oxvendor                ENGINE = InnoDB;
ALTER TABLE oxwrapping              ENGINE = InnoDB;


/* Adapt changed columns and keys */
ALTER TABLE `oxaddress`
  CHANGE `OXCOUNTRYID` `OXCOUNTRYID` char( 32 ) character set latin1 collate latin1_general_ci NOT NULL default '' COMMENT 'Country id (oxcountry)';

ALTER TABLE `oxarticles`
  DROP KEY `OXCOUNT`,
  DROP KEY `OXSHOPID`,
  DROP KEY `OXARTNUM`,
  DROP KEY `OXSTOCK`,
  DROP KEY `OXINSERT`,
  DROP KEY `OXVARNAME`,
  ADD COLUMN OXHIDDEN tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Hidden' AFTER OXACTIVE
;

ALTER TABLE `oxcountry`
  CHANGE COLUMN OXSHORTDESC OXSHORTDESC varchar(255) NOT NULL DEFAULT '' COMMENT 'Short description (multilanguage)',
  CHANGE COLUMN OXSHORTDESC_1 OXSHORTDESC_1 varchar(255) NOT NULL DEFAULT '',
  CHANGE COLUMN OXSHORTDESC_2 OXSHORTDESC_2 varchar(255) NOT NULL DEFAULT '',
  CHANGE COLUMN OXSHORTDESC_3 OXSHORTDESC_3 varchar(255) NOT NULL DEFAULT ''
;

ALTER TABLE `oxdeliveryset`
  CHANGE COLUMN OXTITLE `OXTITLE` varchar(255) NOT NULL DEFAULT '' COMMENT 'Title (multilanguage)',
  CHANGE COLUMN OXTITLE_1 `OXTITLE_1` varchar(255) NOT NULL DEFAULT '',
  CHANGE COLUMN OXTITLE_2 `OXTITLE_2` varchar(255) NOT NULL DEFAULT '',
  CHANGE COLUMN OXTITLE_3 `OXTITLE_3` varchar(255) NOT NULL DEFAULT ''
;

ALTER TABLE `oxobject2attribute`
  CHANGE COLUMN OXVALUE `OXVALUE` varchar(255) NOT NULL DEFAULT '' COMMENT 'Attribute value (multilanguage)'
;

ALTER TABLE `oxshops`
  CHANGE COLUMN OXVERSION OXVERSION char(16) NOT NULL COMMENT 'Shop Version (@deprecated since v6.0.0-RC.2 (2017-08-22))',
  CHANGE COLUMN OXEDITION OXEDITION char(2) NOT NULL COMMENT 'Shop Edition (CE,PE,EE (@deprecated since v6.0.0-RC.2 (2017-08-24))'
;

ALTER TABLE `oxstates`
  DROP PRIMARY KEY,
  ADD PRIMARY KEY(`OXID`,`OXCOUNTRYID`)
;

ALTER TABLE `oxtplblocks`
  CHANGE COLUMN OXMODULE OXMODULE varchar(100) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT 'Module, which uses this template' AFTER OXFILE,
  ADD COLUMN OXTHEME char(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT 'Shop theme id' AFTER OXSHOPID,
  ADD INDEX oxtheme (OXTHEME)
;


/* Fix table collation */
ALTER TABLE `oxinvitations`
  COLLATE=utf8_general_ci
;

ALTER TABLE `oxobject2action`
  COLLATE=utf8_general_ci
;


/* Add missing migration table */
CREATE TABLE IF NOT EXISTS `oxmigrations_ce` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
;

INSERT IGNORE INTO `oxmigrations_ce` (`version`) VALUES
  ('20170718124421')
;


/*
  Insert new config value
*/
INSERT INTO `oxconfig` (`OXID`, `OXSHOPID`, `OXMODULE`, `OXVARNAME`, `OXVARTYPE`, `OXVARVALUE`)
  SELECT
    CONCAT(SUBSTRING(`OXID`,1, 16),SUBSTRING(REPLACE( UUID( ) ,  '-',  '' ), 17,32)) AS `OXID`,
    `OXSHOPID`,
    `OXMODULE`,
    "blSendTechnicalInformationToOxid" AS `OXVARNAME`,
    `OXVARTYPE`,
    `OXVARVALUE`
  FROM `oxconfig`
  WHERE `OXVARNAME` = "blLoadDynContents"
;


/*
 Add new unique index.
 There might be a problem creating this index, if the values in the table are not unique.
*/
ALTER TABLE `oxobject2group`
  DROP INDEX OXOBJECTID,
  DROP INDEX OXGROUPSID,
  ADD UNIQUE INDEX UNIQ_OBJECTGROUP (OXGROUPSID,OXOBJECTID,OXSHOPID),
  ADD INDEX OXOBJECTID (OXOBJECTID)
;
