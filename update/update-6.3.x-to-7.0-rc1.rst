Update 6.3.x to 7.0-rc.1
========================

Update component will be provided with 7.0.0 final release.
We do not recommend to update productive shops to a release candidate.

To not forget:
* All oxcontents table fields OXCONTENT_X (X>3) types should be all updated manually to at least MEDIUMTEXT, Example:
    - "ALTER TABLE `oxcontents` MODIFY column OXCONTENT_4 MEDIUMTEXT NOT NULL"