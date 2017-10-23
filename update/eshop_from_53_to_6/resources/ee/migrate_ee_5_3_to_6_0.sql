/*!40101 SET character_set_client = utf8 */;

UPDATE oxshops SET OXVERSION = '6.0.0', OXNAME = 'OXID eShop 6';


/* Newsletter funtionality was added to OXID eSales  Enterprise Edition */
INSERT INTO `oxactions` (`OXID`, `OXSHOPID`, `OXTYPE`, `OXTITLE`, `OXTITLE_1`, `OXTITLE_2`, `OXTITLE_3`, `OXLONGDESC`, `OXLONGDESC_1`, `OXLONGDESC_2`, `OXLONGDESC_3`, `OXACTIVE`, `OXACTIVEFROM`, `OXACTIVETO`, `OXPIC`, `OXPIC_1`, `OXPIC_2`, `OXPIC_3`, `OXLINK`, `OXLINK_1`, `OXLINK_2`, `OXLINK_3`, `OXSORT`) VALUES
('oxnewsletter', 1, 0, 'Newsletter', 'Newsletter', '', '', '', '', '', '', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', '', '', '', '', '', '', '', 0);

CREATE TABLE `oxnewsletter` (
  `OXID` CHAR(32) NOT NULL COMMENT 'Newsletter id' COLLATE 'latin1_general_ci',
  `OXSHOPID` INT(11) NOT NULL DEFAULT '1' COMMENT 'Shop id (oxshops)',
  `OXTITLE` VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Title',
  `OXTEMPLATE` MEDIUMTEXT NOT NULL COMMENT 'HTML template',
  `OXPLAINTEMPLATE` MEDIUMTEXT NOT NULL COMMENT 'Plain template',
  `OXSUBJECT` VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Subject' COLLATE 'latin1_general_ci',
  `OXTIMESTAMP` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Timestamp',
  PRIMARY KEY (`OXID`)
)
  COMMENT='Templates for sending newsletters'
  COLLATE='utf8_general_ci'
  ENGINE=InnoDB
;


/*
 Add explicit sorting to the table `oxdiscount`
 Important note: this migration must run prior the change of the storage engine to InnoDB
*/
ALTER TABLE `oxdiscount` ADD COLUMN `OXSORT` INT(5) NOT NULL DEFAULT '0' COMMENT 'Defines the order discounts are applied to basket or product' AFTER `OXITMMULTIPLE`;
UPDATE `oxdiscount` CROSS JOIN (SELECT @rownumber := 0) r SET `oxdiscount`.`OXSORT` = (@rownumber := @rownumber + 10);
ALTER TABLE `oxdiscount` ADD UNIQUE INDEX `UNIQ_OXSORT` (`OXSHOPID`, `OXSORT`);


/* Change storage engine for all tables to InnoDB*/
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
ALTER TABLE oxcache                  ENGINE = InnoDB;
ALTER TABLE oxfield2role             ENGINE = InnoDB;
ALTER TABLE oxfield2shop             ENGINE = InnoDB;
ALTER TABLE oxobject2role            ENGINE = InnoDB;
ALTER TABLE oxobjectrights           ENGINE = InnoDB;
ALTER TABLE oxrolefields             ENGINE = InnoDB;
ALTER TABLE oxroles                  ENGINE = InnoDB;


/* Adapt changed columns and keys */
ALTER TABLE `oxadminlog`
  CHANGE COLUMN OXSQL OXSQL text NOT NULL COMMENT 'Logged sql' AFTER OXUSERID
;

ALTER TABLE `oxarticles`
  ADD COLUMN OXBUNDLEID varchar(32) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '' COMMENT 'Bundled article id' AFTER OXSEARCHKEYS_3,
  ADD COLUMN OXHIDDEN tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Hidden' AFTER OXACTIVE
;

ALTER TABLE `oxattribute`
  CHANGE COLUMN OXMAPID `OXMAPID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Integer mapping identifier'
;

ALTER TABLE `oxcountry`
  CHANGE COLUMN OXSHORTDESC_1 OXSHORTDESC_1 varchar(255) NOT NULL DEFAULT '',
  CHANGE COLUMN OXSHORTDESC_2 OXSHORTDESC_2 varchar(255) NOT NULL DEFAULT '',
  CHANGE COLUMN OXSHORTDESC_3 OXSHORTDESC_3 varchar(255) NOT NULL DEFAULT ''
;

ALTER TABLE `oxdeliveryset`
  CHANGE COLUMN OXTITLE `OXTITLE` char(255) NOT NULL DEFAULT '' COMMENT 'Title (multilanguage)',
  CHANGE COLUMN OXTITLE_1 OXTITLE_1 char(255) NOT NULL DEFAULT '',
  CHANGE COLUMN OXTITLE_2 OXTITLE_2 char(255) NOT NULL DEFAULT '',
  CHANGE COLUMN OXTITLE_3 OXTITLE_3 char(255) NOT NULL DEFAULT ''
;

ALTER TABLE `oxgroups`
  CHANGE COLUMN OXRRID OXRRID bigint(21) unsigned NOT NULL COMMENT 'Group numeric index' AFTER OXID
;

ALTER TABLE `oxinvitations`
  COLLATE=utf8_general_ci, COMMENT='User sent invitations'
;

ALTER TABLE `oxshops`
  CHANGE COLUMN OXISINHERITED OXISINHERITED int(11) NOT NULL DEFAULT '0' COMMENT 'Shop inherits all inheritable items (products, discounts etc) from it`s parent shop',
  CHANGE COLUMN OXSERIAL OXSERIAL varchar(255) NOT NULL DEFAULT '' COMMENT 'Shop license number' AFTER OXTIMESTAMP,
  CHANGE COLUMN OXEDITION OXEDITION char(2) NOT NULL COMMENT 'Shop Edition (CE,PE,EE (@deprecated since v6.0.0-RC.2 (2017-08-24))' AFTER OXAFFILI24ID,
  CHANGE COLUMN OXVERSION OXVERSION char(16) NOT NULL COMMENT 'Shop Version (@deprecated since v6.0.0-RC.2 (2017-08-22))' AFTER OXEDITION
;

ALTER TABLE `oxstates`
  DROP PRIMARY KEY,
  ADD PRIMARY KEY(`OXID`,`OXCOUNTRYID`)
;

ALTER TABLE `oxtplblocks`
  DROP INDEX search,
  ADD INDEX oxtheme (OXTHEME),
  ADD INDEX `search` (`OXACTIVE`,`OXSHOPID`,`OXTEMPLATE`,`OXPOS`),
  CHANGE COLUMN OXMODULE `OXMODULE` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT 'Module, which uses this template' AFTER OXFILE,
  ADD COLUMN OXTHEME char(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL COMMENT 'Shop theme id' AFTER OXSHOPID
;


/* Fix table collation */
ALTER TABLE `oxarticles2shop`
  COLLATE=utf8_general_ci, COMMENT='Mapping table for element subshop assignments';

ALTER TABLE `oxattribute2shop`
  COLLATE=utf8_general_ci, COMMENT='Mapping table for element subshop assignments';

ALTER TABLE `oxcategories2shop`
  COLLATE=utf8_general_ci, COMMENT='Mapping table for element subshop assignments';

ALTER TABLE `oxdelivery2shop`
  COLLATE=utf8_general_ci, COMMENT='Mapping table for element subshop assignments';

ALTER TABLE `oxdeliveryset2shop`
  COLLATE=utf8_general_ci, COMMENT='Mapping table for element subshop assignments';

ALTER TABLE `oxdiscount2shop`
  COLLATE=utf8_general_ci, COMMENT='Mapping table for element subshop assignments';

ALTER TABLE `oxlinks2shop`
  COLLATE=utf8_general_ci, COMMENT='Mapping table for element subshop assignments';

ALTER TABLE `oxmanufacturers2shop`
  COLLATE=utf8_general_ci, COMMENT='Mapping table for element subshop assignments';

ALTER TABLE `oxnews2shop`
  COLLATE=utf8_general_ci, COMMENT='Mapping table for element subshop assignments';

ALTER TABLE `oxobject2action`
  COLLATE=utf8_general_ci, COMMENT='Shows many-to-many relationship between actions (oxactions) and objects (table set by oxclass)';

ALTER TABLE `oxselectlist2shop`
  COLLATE=utf8_general_ci, COMMENT='Mapping table for element subshop assignments';

ALTER TABLE `oxvendor2shop`
  COLLATE=utf8_general_ci, COMMENT='Mapping table for element subshop assignments';

ALTER TABLE `oxvoucherseries2shop`
  COLLATE=utf8_general_ci, COMMENT='Mapping table for element subshop assignments';

ALTER TABLE `oxwrapping2shop`
  COLLATE=utf8_general_ci, COMMENT='Mapping table for element subshop assignments';


/* Add missing migration tables */
CREATE TABLE IF NOT EXISTS `oxmigrations_ce` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
INSERT IGNORE INTO `oxmigrations_ce` (`version`) VALUES
  ('20170718124421');

CREATE TABLE IF NOT EXISTS `oxmigrations_ee` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
INSERT IGNORE INTO `oxmigrations_ee` (`version`) VALUES
  ('20160919103142_pe_to_ee');

CREATE TABLE IF NOT EXISTS `oxmigrations_pe` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
INSERT IGNORE INTO `oxmigrations_pe` (`version`) VALUES
  ('20160919103142_ce_to_pe');


/* Insert new config value */
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
 Fix order of keys and indexes. We need this to be able to compare the database structures without having too much noise.
*/
ALTER TABLE `oxarticles`
  DROP INDEX OXACTIVEFROM,
  DROP INDEX OXISDOWNLOADABLE,
  DROP INDEX OXACTIVETO,
  DROP INDEX OXVENDORID,
  DROP PRIMARY KEY,
  DROP INDEX OXSORT,
  DROP INDEX OXSTOCKFLAG,
  DROP INDEX parentsort,
  DROP INDEX OXPARENTID,
  DROP INDEX OXPRICE,
  DROP INDEX OXMANUFACTURERID,
  DROP INDEX OXACTIVE,
  DROP INDEX OXMAPID,
  DROP INDEX OXISSEARCH,
  DROP INDEX OXSOLDAMOUNT,
  DROP INDEX OXUPDATEPRICETIME,
  ADD PRIMARY KEY(`OXID`),
  ADD INDEX OXSORT (OXSORT),
  ADD INDEX OXISSEARCH (OXISSEARCH),
  ADD INDEX OXSTOCKFLAG (OXSTOCKFLAG),
  ADD INDEX OXACTIVE (OXACTIVE),
  ADD INDEX OXACTIVEFROM (OXACTIVEFROM),
  ADD INDEX OXACTIVETO (OXACTIVETO),
  ADD INDEX OXVENDORID (OXVENDORID),
  ADD INDEX OXMANUFACTURERID (OXMANUFACTURERID),
  ADD INDEX OXSOLDAMOUNT (OXSOLDAMOUNT),
  ADD INDEX parentsort (OXPARENTID, OXSORT),
  ADD INDEX OXUPDATEPRICETIME (OXUPDATEPRICETIME),
  ADD INDEX OXISDOWNLOADABLE (OXISDOWNLOADABLE),
  ADD INDEX OXPRICE (OXPRICE),
  ADD INDEX OXPARENTID (OXPARENTID),
  ADD INDEX OXMAPID (OXMAPID)
;

ALTER TABLE `oxmanufacturers`
  DROP INDEX OXMAPID,
  DROP PRIMARY KEY,
  DROP INDEX OXACTIVE,
  DROP INDEX OXSHOPID,
  ADD PRIMARY KEY(`OXID`),
  ADD INDEX OXMAPID (OXMAPID),
  ADD INDEX OXSHOPID (OXSHOPID),
  ADD INDEX OXACTIVE (OXACTIVE),
  COMMENT='Shop manufacturers'
;

ALTER TABLE `oxnewssubscribed`
  DROP INDEX OXEMAIL,
  DROP INDEX OXUSERID,
  ADD INDEX OXUSERID (OXUSERID),
  ADD INDEX OXEMAIL (OXEMAIL)
;

ALTER TABLE `oxobject2attribute`
  DROP PRIMARY KEY,
  DROP INDEX mainidx,
  DROP INDEX OXOBJECTID,
  ADD PRIMARY KEY(`OXID`),
  ADD INDEX OXOBJECTID (OXOBJECTID),
  ADD INDEX mainidx (`OXATTRID`,`OXOBJECTID`)
;

ALTER TABLE `oxobject2category`
  DROP INDEX OXMAINIDX,
  DROP INDEX OXOBJECTID,
  DROP INDEX OXTIME,
  DROP INDEX OXSHOPID,
  DROP INDEX OXPOS,
  ADD INDEX OXOBJECTID (OXOBJECTID),
  ADD INDEX OXPOS (OXPOS),
  ADD INDEX OXTIME (OXTIME),
  ADD INDEX OXMAINIDX (`OXCATNID`,`OXOBJECTID`),
  ADD INDEX OXSHOPID (OXSHOPID)
;

ALTER TABLE `oxobject2discount`
  DROP INDEX mainidx,
  DROP INDEX oxdiscidx,
  ADD INDEX `oxdiscidx` (`OXDISCOUNTID`,`OXTYPE`),
  ADD INDEX `mainidx` (`OXOBJECTID`,`OXDISCOUNTID`,`OXTYPE`)
;

ALTER TABLE `oxorder`
  DROP INDEX OXUSERID,
  DROP INDEX MAINIDX,
  DROP INDEX OXORDERNR,
  ADD INDEX `MAINIDX` (`OXSHOPID`,`OXORDERDATE`),
  ADD INDEX `OXUSERID` (`OXUSERID`),
  ADD INDEX `OXORDERNR` (`OXORDERNR`)
;

ALTER TABLE `oxselectlist`
  DROP INDEX OXTITLE,
  DROP INDEX OXSHOPID,
  DROP INDEX OXMAPID,
  ADD INDEX OXMAPID (OXMAPID),
  ADD INDEX OXSHOPID (OXSHOPID),
  ADD INDEX OXTITLE (OXTITLE)
;

ALTER TABLE `oxuser`
  DROP INDEX OXSHOPID,
  DROP INDEX OXLNAME,
  DROP INDEX OXACTIVE,
  DROP INDEX OXUPDATEEXP,
  ADD INDEX `OXACTIVE` (`OXACTIVE`),
  ADD INDEX `OXLNAME` (`OXLNAME`),
  ADD INDEX `OXUPDATEEXP` (`OXUPDATEEXP`),
  ADD INDEX `OXSHOPID` (`OXSHOPID`,`OXUSERNAME`)
;

ALTER TABLE `oxvendor`
  DROP INDEX OXACTIVE,
  DROP INDEX OXSHOPID,
  DROP INDEX OXMAPID,
  ADD INDEX OXACTIVE (OXACTIVE),
  ADD INDEX OXMAPID (OXMAPID),
  ADD INDEX OXSHOPID (OXSHOPID)
;

ALTER TABLE `oxwrapping`
  DROP INDEX OXSHOPID,
  DROP INDEX OXMAPID,
  ADD INDEX OXMAPID (OXMAPID),
  ADD INDEX OXSHOPID (OXSHOPID)
;


/*
 Add new unique index.
 There might be a problem creating this index, if the values in the table are not unique.
*/
ALTER TABLE `oxobject2group`
  DROP INDEX OXGROUPSID,
  DROP INDEX OXOBJECTID,
  ADD UNIQUE INDEX `UNIQ_OBJECTGROUP` (`OXGROUPSID`,`OXOBJECTID`,`OXSHOPID`),
  ADD INDEX OXOBJECTID (OXOBJECTID)
;
