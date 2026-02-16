Upgrading from the Professional Edition Edition to the Enterprise Edition
=========================================================================

Upgrading from the Professional Edition (PE) edition to the Enterprise Edition (EE).

|procedure|

#. Add `oxideshop-metapackage-ee` to your root :file:`composer.json`:

   .. code:: bash

    composer config repositories.oxid-esales composer https://enterprise-edition.packages.oxid-esales.com

#. Install `oxideshop-metapackage-ee` using composer without executing any scripts:

   .. code:: bash

     composer require oxid-esales/oxideshop-metapackage-ee:^7 --no-plugins --no-scripts

#. Run the shop migrations:

   .. code:: bash

     vendor/bin/oe-eshop-db_migrate migrations:migrate

#. Regenerate the database views:

   .. code:: bash

    vendor/bin/oe-eshop-db_views_generate

#. Update the dependencies for your EE shop and modules:

   .. code:: bash

    composer update

Known Issues
------------

Migration fails with "Duplicate entry '1-901'" error
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Affected versions**: OXID eShop 6.x and 7.x

**Problem**:

When running EE migrations on a database with 901 or more articles, the migration ``Version20160919103142.php`` fails with the error:

.. code::

   Duplicate entry '1-901' for key 'oxdeliveryset2shop.OXMAPIDX'

This happens because the migration inserts a hardcoded entry ``(1, 901)`` into ``oxdeliveryset2shop``, then tries to insert all articles from ``oxarticles``. If any article has ``OXSHOPID=1`` and ``OXMAPID=901``, a duplicate key violation occurs.

**Workaround**:

.. warning::

   Before applying this workaround, create a backup of your database in case of any errors:

   .. code:: bash

      mysqldump -u [user] -p [database] > backup_before_ee_migration.sql

Run the following SQL script **before** step 3 (Run the shop migrations):

.. code:: sql

   -- PRE-MIGRATION FIX: Prevent duplicate entry '1-901' error

   -- Step 1: Create temp table to track changed articles
   DROP TABLE IF EXISTS _temp_fix_articles;
   CREATE TABLE _temp_fix_articles (
       OXID char(32) NOT NULL PRIMARY KEY
   );

   -- Step 2: Save all articles with OXSHOPID=1
   INSERT INTO _temp_fix_articles (OXID)
   SELECT OXID FROM oxarticles WHERE OXSHOPID = 1;

   -- Step 3: Temporarily change all to OXSHOPID=999
   UPDATE oxarticles SET OXSHOPID = 999 WHERE OXSHOPID = 1;

Then run the shop migrations:

.. code:: bash

   vendor/bin/oe-eshop-db_migrate migrations:migrate

Then regenerate database views:

.. code:: bash

   vendor/bin/oe-eshop-db_views_generate

After migrations complete successfully, run the following SQL to restore the articles:

.. code:: sql

   -- POST-MIGRATION RESTORE

   -- Step 1: Restore OXSHOPID=1 for all changed articles
   UPDATE oxarticles a
   JOIN _temp_fix_articles t ON a.OXID = t.OXID
   SET a.OXSHOPID = 1;

   -- Step 2: Add articles to oxarticles2shop mapping
   INSERT IGNORE INTO oxarticles2shop (OXSHOPID, OXMAPOBJECTID)
   SELECT 1, a.OXMAPID
   FROM oxarticles a
   JOIN _temp_fix_articles t ON a.OXID = t.OXID;

   -- Step 3: Clean up
   DROP TABLE IF EXISTS _temp_fix_articles;

Then continue with step 5 (Update the dependencies):

.. code:: bash

   composer update

Then regenerate database views again:

.. code:: bash

   vendor/bin/oe-eshop-db_views_generate
