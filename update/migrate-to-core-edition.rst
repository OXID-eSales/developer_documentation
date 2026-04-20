Migrating to the Core Edition
=============================

This guide describes how to migrate an existing OXID eShop
6.5.5 installation from the standard compilation metapackage
to the Core Edition metapackage.

The instructions and version numbers in this guide are based
on a **standard, unmodified compilation installation**. If
your shop has been individually patched, has custom module
versions, or uses additional Composer repositories, you will
need to adapt the steps accordingly. Always verify against
your actual ``composer.lock`` rather than relying on the
versions listed here.

For background on what the Core Edition is and why it exists,
see the `user documentation
<https://docs.oxid-esales.com/eshop/en/6.5/installation/
core-edition.html>`_.

Prerequisites
-------------

* An existing OXID eShop 6.5.5 installation using the
  standard compilation metapackage
* Composer 2.7.7 or later
* Access to a development or staging environment

.. important::

   **Never run this migration directly on a production
   system.** Always test on development or staging first.
   Verify all modules, payment methods, and checkout flows
   before deploying to production.

How the metapackage swap works
-------------------------------

The compilation metapackage (e.g.
``oxid-esales/oxideshop-metapackage-ce``) is a virtual
package — it installs no files of its own, only declares
requirements. When you replace it with the Core Edition
metapackage, Composer recalculates the dependency tree. Any
package that was only required through the old metapackage —
and is not explicitly listed in your ``composer.json`` — will
be **removed**.

This includes **active, running modules**. Composer does not
check whether a module is activated in OXID — it only looks
at ``composer.json``.

The shop core remains at the same version. Both the standard
and Core Edition metapackages pin the same
``oxid-esales/oxideshop-ce v6.14.4``. This is not an upgrade.

.. todo::

   **Remove this section before publishing.** The following
   steps are only needed while the Core Edition metapackages
   are not yet tagged on Packagist/Satis. Once tagged as
   ``v6.5.5``, drop these steps and change the version
   constraint in Step 5 from ``dev-b-6.5-release`` to
   ``v6.5.5``.

   **Pre-release setup (remove after tagging):**

   .. code:: bash

      composer config minimum-stability dev
      composer config prefer-stable true
      composer config repositories.metapackage-ce-core vcs https://github.com/OXID-eSales/metapackage-ce-core
      composer config repositories.metapackage-pe-core vcs https://github.com/OXID-eSales/metapackage-pe-core
      composer config repositories.metapackage-ee-core vcs https://github.com/OXID-eSales/metapackage-ee-core

   And use ``dev-b-6.5-release`` instead of ``v6.5.5`` as
   the version constraint for the Core Edition metapackage
   in Step 5.

Step 1 — Backup
----------------

.. code:: bash

   cp composer.json composer.json.bak
   cp composer.lock composer.lock.bak

Step 2 — Snapshot installed packages
--------------------------------------

Create a list of all currently installed packages for later
verification:

.. code:: bash

   php -r "
     \$lock = json_decode(
         file_get_contents('composer.lock'), true
     );
     foreach (\$lock['packages'] as \$p)
         echo \$p['name'] . ' '
              . \$p['version'] . \"\n\";
   " | sort > packages-before.txt

Step 3 — Clear the container cache
------------------------------------

The OXID Composer plugin loads the shop's dependency
injection container during package install and uninstall
operations. If the container cache references packages that
are being removed, Composer will fail. Clear the cache
before proceeding:

.. code:: bash

   vendor/bin/oe-console oe:cache:clear

Step 4 — Identify modules and dependencies to preserve
--------------------------------------------------------

The following modules are bundled in the standard CE
compilation but **not** in the Core Edition. If your shop
uses any of them, you must add them as explicit requirements
in Step 5.

Additionally, some modules have transitive dependencies that
were pinned by the standard compilation. These must also be
pinned explicitly to prevent version drift during the swap.
Check the versions from your ``composer.lock`` — if your
shop has been patched, the installed versions may differ
from the ones listed here.

**CE modules:**

.. list-table::
   :header-rows: 1
   :widths: 50 20

   * - Package
     - Version
   * - ``ddoe/wysiwyg-editor-module``
     - v2.4.2
   * - ``fatchip-gmbh/oxid-klarna-6``
     - v5.5.3
   * - ``makaira/oxid-connect-essential``
     - 1.4.5
   * - ``oxid-esales/gdpr-optin-module``
     - v2.3.3
   * - ``oxid-esales/paypal-module``
     - v6.5.0
   * - ``oxid-professional-services/usercentrics``
     - v1.2.1
   * - ``payone-gmbh/oxid-6``
     - v1.9.0

**CE transitive dependencies** (pulled by modules above):

.. list-table::
   :header-rows: 1
   :widths: 50 20

   * - Package
     - Version
   * - ``kore/data-object``
     - 1.3
   * - ``makaira/shared-libs``
     - 2022.2.1
   * - ``rmccue/requests``
     - v1.8.1
   * - ``symfony/http-foundation``
     - v5.4.25

**PE additionally:**

* ``ddoe/visualcms-module`` v3.7.0

**EE additionally:**

.. list-table::
   :header-rows: 1
   :widths: 50 20

   * - Package
     - Version
   * - ``oxid-esales/unzer``
     - v1.2.1
   * - ``unzerdev/php-sdk``
     - 3.4.1
   * - ``guzzlehttp/guzzle``
     - 7.7.0
   * - ``guzzlehttp/promises``
     - 2.0.0
   * - ``guzzlehttp/psr7``
     - 2.5.0
   * - ``psr/http-client``
     - 1.0.2
   * - ``psr/http-factory``
     - 1.0.2
   * - ``psr/http-message``
     - 2.0
   * - ``ralouphie/getallheaders``
     - 3.0.3

Step 5 — Remove old metapackage and require Core Edition
----------------------------------------------------------

Use ``--no-update`` on every command to prepare all changes
without triggering an install in between.

.. note::

   Only add the modules your shop actually uses. You do not
   need to re-add modules you want to remove. This is your
   opportunity to clean up unused modules. However, always
   pin the transitive dependencies for the modules you keep.

**CE:**

.. code:: bash

   composer remove oxid-esales/oxideshop-metapackage-ce --no-update

   composer require oxid-esales/metapackage-ce-core:v6.5.5 --no-update

   # Modules (add only those your shop uses)
   composer require ddoe/wysiwyg-editor-module:v2.4.2 --no-update
   composer require fatchip-gmbh/oxid-klarna-6:v5.5.3 --no-update
   composer require makaira/oxid-connect-essential:1.4.5 --no-update
   composer require oxid-esales/gdpr-optin-module:v2.3.3 --no-update
   composer require oxid-esales/paypal-module:v6.5.0 --no-update
   composer require oxid-professional-services/usercentrics:v1.2.1 --no-update
   composer require payone-gmbh/oxid-6:v1.9.0 --no-update

   # Transitive dependencies (pin to prevent version drift)
   composer require kore/data-object:1.3 --no-update
   composer require makaira/shared-libs:2022.2.1 --no-update
   composer require rmccue/requests:v1.8.1 --no-update
   composer require symfony/http-foundation:v5.4.25 --no-update

**PE:**

.. code:: bash

   composer remove oxid-esales/oxideshop-metapackage-pe --no-update

   composer require oxid-esales/metapackage-pe-core:v6.5.5 --no-update

   # PE module
   composer require ddoe/visualcms-module:v3.7.0 --no-update

   # CE modules (add only those your shop uses)
   composer require ddoe/wysiwyg-editor-module:v2.4.2 --no-update
   composer require fatchip-gmbh/oxid-klarna-6:v5.5.3 --no-update
   composer require makaira/oxid-connect-essential:1.4.5 --no-update
   composer require oxid-esales/gdpr-optin-module:v2.3.3 --no-update
   composer require oxid-esales/paypal-module:v6.5.0 --no-update
   composer require oxid-professional-services/usercentrics:v1.2.1 --no-update
   composer require payone-gmbh/oxid-6:v1.9.0 --no-update

   # Transitive dependencies
   composer require kore/data-object:1.3 --no-update
   composer require makaira/shared-libs:2022.2.1 --no-update
   composer require rmccue/requests:v1.8.1 --no-update
   composer require symfony/http-foundation:v5.4.25 --no-update

**EE:**

.. code:: bash

   composer remove oxid-esales/oxideshop-metapackage-ee --no-update

   composer require oxid-esales/metapackage-ee-core:v6.5.5 --no-update

   # PE module
   composer require ddoe/visualcms-module:v3.7.0 --no-update

   # EE module
   composer require oxid-esales/unzer:v1.2.1 --no-update

   # CE modules (add only those your shop uses)
   composer require ddoe/wysiwyg-editor-module:v2.4.2 --no-update
   composer require fatchip-gmbh/oxid-klarna-6:v5.5.3 --no-update
   composer require makaira/oxid-connect-essential:1.4.5 --no-update
   composer require oxid-esales/gdpr-optin-module:v2.3.3 --no-update
   composer require oxid-esales/paypal-module:v6.5.0 --no-update
   composer require oxid-professional-services/usercentrics:v1.2.1 --no-update
   composer require payone-gmbh/oxid-6:v1.9.0 --no-update

   # EE transitive dependencies (Unzer + HTTP stack)
   composer require unzerdev/php-sdk:3.4.1 --no-update
   composer require guzzlehttp/guzzle:7.7.0 --no-update
   composer require guzzlehttp/promises:2.0.0 --no-update
   composer require guzzlehttp/psr7:2.5.0 --no-update
   composer require psr/http-client:1.0.2 --no-update
   composer require psr/http-factory:1.0.2 --no-update
   composer require psr/http-message:2.0 --no-update
   composer require ralouphie/getallheaders:3.0.3 --no-update

   # CE transitive dependencies
   composer require kore/data-object:1.3 --no-update
   composer require makaira/shared-libs:2022.2.1 --no-update
   composer require rmccue/requests:v1.8.1 --no-update
   composer require symfony/http-foundation:v5.4.25 --no-update

Step 6 — Run composer update
------------------------------

Run the update in two passes. The first pass updates
packages without triggering the OXID Composer plugin, which
would otherwise fail if the container cache references
packages that are being removed. The second pass runs the
plugin hooks to finalize the installation.

.. code:: bash

   composer update --no-plugins --no-scripts
   composer update

.. note::

   You may see a warning about
   ``composer/package-versions-deprecated`` not being loaded.
   This is harmless and can be ignored.

Step 7 — Verify
-----------------

.. code:: bash

   php -r "
     \$lock = json_decode(
         file_get_contents('composer.lock'), true
     );
     foreach (\$lock['packages'] as \$p)
         echo \$p['name'] . ' '
              . \$p['version'] . \"\n\";
   " | sort > packages-after.txt

   diff packages-before.txt packages-after.txt

**Expected diff:**

* Lines removed: the old metapackage(s)
  (e.g. ``oxid-esales/oxideshop-metapackage-ee v6.5.5``,
  plus the CE and PE metapackages for PE/EE installations)
* Lines added: the Core Edition metapackage(s)
  (e.g. ``oxid-esales/metapackage-ee-core v6.5.5``)
* Lines removed for modules you intentionally did not
  re-add

If you pinned all transitive dependencies, there should be
**no version changes** in the remaining packages. Any
unexpected difference must be investigated before deploying
to production.

Rollback
--------

If anything goes wrong, restore from backup:

.. code:: bash

   cp composer.json.bak composer.json
   cp composer.lock.bak composer.lock
   composer install --no-plugins --no-scripts
   composer install

Composer 2.9 security audit
-----------------------------

Composer 2.9 performs strict security audits during
``composer update``. If your Composer version is 2.7 or 2.8,
you will not encounter this issue. On Composer 2.9+, the
update will fail if known security advisories exist for
installed packages.

The OXID eShop 6.5.5 compilation includes packages with
known CVEs that cannot be resolved by updating within 6.5
— the affected versions are pinned by design. To proceed
with the migration, add the following ``audit.ignore``
block to the ``config`` section of your ``composer.json``:

.. code:: json

   "config": {
       "audit": {
           "ignore": [
               "PKSA-28zg-9h7g-fhvp",
               "PKSA-54c6-f9b9-7wg4",
               "PKSA-wy1k-8qg5-z8xd",
               "PKSA-yr6f-z9sx-cps3",
               "PKSA-2q9d-8kh9-49wx",
               "PKSA-pght-23ww-rrdy",
               "PKSA-6y8p-nrf4-ysf5",
               "PKSA-98zc-53yc-qt81",
               "PKSA-31hv-m6rg-8ryk",
               "PKSA-wc9h-gs49-76tm",
               "PKSA-t4kv-1sv2-1mzx",
               "PKSA-thph-wfk6-pp4j",
               "PKSA-hgp5-21g7-7phg",
               "PKSA-365x-2zjk-pt47",
               "PKSA-b35n-565h-rs4q",
               "PKSA-wws7-mr54-jsny",
               "PKSA-1gck-s111-yq7g",
               "PKSA-hjpv-ct4c-8fq5",
               "PKSA-t5r2-p5q9-mtpn",
               "PKSA-6bp1-9hfj-2cgv"
           ]
       }
   }

These advisories affect the following packages:

.. list-table::
   :header-rows: 1
   :widths: 30 15 55

   * - Package
     - Count
     - Context
   * - ``smarty/smarty`` v2.6.33
     - 13
     - Legacy template engine used by OXID 6.x.
       Smarty 2.x is end-of-life and does not receive
       fixes. OXID 7.x replaced Smarty with Twig.
   * - ``composer/composer`` 2.7.7
     - 3
     - Composer itself, pinned at 2.7.7 by the
       compilation. The CVEs affect Perforce source
       handling and ANSI injection — not relevant for
       normal shop operation.
   * - ``oxid-esales/oxideshop-ce`` v6.14.4
     - 1
     - Addressed in OXID eShop 7.x. The fix cannot be
       backported to 6.x without breaking changes.
   * - ``symfony/process``
     - 1
     - Windows-only command execution issue
       (CVE-2024-51736). Not relevant for Linux-hosted
       shops.

.. important::

   These are known limitations of the OXID eShop 6.5
   technology stack. They cannot be resolved by updating
   individual packages — the affected versions are the
   ones tested and shipped with the compilation. Updating
   to OXID eShop 7.4.1 or later with the Twig template
   engine resolves all of them.

Module management after migration
-----------------------------------

After the migration, you manage modules directly via
Composer:

.. code:: bash

   # Update a module
   composer update vendor/module-name

   # Remove a module
   composer remove vendor/module-name

   # Install a new module
   composer require vendor/new-module-name

After any module change:

.. code:: bash

   vendor/bin/oe-console oe:cache:clear
   vendor/bin/oe-console oe:module:activate module-id
   vendor/bin/oe-console oe:database:generateviews
