Scripts to help porting any module to OXID eShop 6
==================================================

This document provides a complementary information to the previously written "`Steps to port a module for the OXID eShop version 6.0`_". It describes how it's possible to automate the majority of module porting actions by using the scripts written below. Feel free to use the provided information as an additional aid to reduce the time needed and increase the quality of the outcome while porting old OXID eShop modules.

Environment requirements
------------------------

OXID eShop VM
^^^^^^^^^^^^^

All scripts which are used in the segments below were tested inside the `official OXID eShop VM`_ with an existing installation of OXID eShop version `v6.0.0`_ and with development requirements included (e.g. `oxid-esales/testing-library`_).

Custom environment
^^^^^^^^^^^^^^^^^^

Despite the fact that it's much easier to get started with an OXID eShop VM it's also possible to use any other environment which would match the `system requirements`_ raised by OXID eShop `v6.0.0`_.

On top of the requirements set by OXID eShop the following tools are being used throughout the sections below (minimum already tested version is provided in parentheses):

* GNU ``find`` (`>=4.4.2`)
* GNU ``grep`` (`>=2.16`)
* GNU ``sed`` (`>=4.2.2`)
* GNU ``less`` (`>=458`)
* GNU ``wc`` (`>=8.21`)
* GNU ``cat`` (`>=8.21`)
* GNU ``tail`` (`>=8.21`)
* FSF ``iconv`` (`>=2.19`)
* BSD ``file`` (`>=5.14`)

Mandatory actions
^^^^^^^^^^^^^^^^^

Before starting to execute scripts which are written in the sections below be sure to export the following environment variables:

* ``ESHOP_PATH`` - full path to where eShop is installed (by default in VM it's ``/var/www/oxideshop``);
* ``MODULE_NAME`` - directory name of module (``vendor_name/module_name``) which is being ported;
* ``OLD_MODULE_NAME`` - directory name of module (``vendor_name/module_name``) which is not ported yet (*an older version of the same module*).

An example on how to set the environment variables if the module in question would be `oxid-esales/paypal-module`_:

::
  
  export ESHOP_PATH="/var/www/oxideshop"
  export MODULE_NAME="oe/paypal"
  export OLD_MODULE_NAME="oe/paypal_old"

In the above example ``oe/paypal_old`` represents an older version of `oxid-esales/paypal-module`_ (*not ported yet*).

Porting topics
--------------

All module porting process is divided into separate topics which in turn are grouped in two lists:

* **Minimal** - Mandatory changes required to work with OXID eShop ``>=`` `v6.0.0`_;
* **Full** - Optional, but **highly recommended** changes.

Minimal porting
^^^^^^^^^^^^^^^

1. Ensure tests are running and covers important logic
2. Convert all files to UTF-8
3. Adjust for BC breaks in PHP versions
4. Adjust removed functionality
5. Adjust your database code to the new DB Layer

Full porting
^^^^^^^^^^^^

6. Adjust the code style of your modules code
7. Replace BC Layer classes
8. Installable via composer
9. Introduce a namespace in your module

1. Ensure tests are running and covers important logic
------------------------------------------------------

Execute tests
^^^^^^^^^^^^^

The following line will initiate tests for the given module only. In order to pass this criteria there should **not be** any **failures** or **errors**.

::

  (cd "$ESHOP_PATH" && PARTIAL_MODULE_PATHS="$MODULE_NAME" ADDITIONAL_TEST_PATHS='' RUN_TESTS_FOR_SHOP=0 RUN_TESTS_FOR_MODULES=1 ACTIVATE_ALL_MODULES=1 vendor/bin/runtests)


Generate code coverage
^^^^^^^^^^^^^^^^^^^^^^

The line below will initiate execution of tests and generation of code coverage for given module only. It uses functionality provided by ``xdebug`` so this extension must be loaded and activated in order to proceed. In order to pass this criteria make sure the most important logic is covered by the tests.

::

  (cd "$ESHOP_PATH" && PARTIAL_MODULE_PATHS="$MODULE_NAME" ADDITIONAL_TEST_PATHS='' RUN_TESTS_FOR_SHOP=0 RUN_TESTS_FOR_MODULES=1 ACTIVATE_ALL_MODULES=1 vendor/bin/runtests --coverage-html="$ESHOP_PATH/coverage_report/$MODULE_NAME" AllTestsUnit)

.. note::

  Due to the limitation of PHPUnit v8 https://github.com/sebastianbergmann/phpunit/issues/4533 OXID eShop Testing Library can not generate code coverage with PHP v8. Please switch your development environment to PHP v7 if you want to generate code coverage with OXID eShop Testing Library and PHPUnit v8.

2. Convert all files to UTF-8
-----------------------------

Files encoded
^^^^^^^^^^^^^

The following script will print out any file which is not ``UTF-8`` compatible (``UTF-8`` and ``us-ascii``). In order to pass this criteria the output should empty.

::
  
  (cd "$ESHOP_PATH/source/modules/$MODULE_NAME/" && find . -type f -regex ".*/.*\.\(php\|tpl\|sql\)" -exec file -i "{}" \; | grep -v 'us-ascii' | grep -v 'utf-8')

In case there are non ``UTF-8`` compatible files one can simply use utility called ``iconv`` which helps to re-encode given files to make them ``UTF-8`` compatible, please consider the following example:

::

  iconv -f ISO-8859-1 -t UTF-8 input.php > output.php

Encoding in translation files
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

All translation files should explicitly declare ``UTF-8`` as encoding. The following three commands will return the same number of lines in case all translation files have explicit declaration of ``UTF-8`` as encoding:

::

  find "$ESHOP_PATH/source/modules/$MODULE_NAME/" | grep '_lang.php' | wc -l
  grep --include \*_lang.php -r 'charset' "$ESHOP_PATH/source/modules/$MODULE_NAME/" | wc -l
  grep --include \*_lang.php -r 'charset' "$ESHOP_PATH/source/modules/$MODULE_NAME/" | grep 'UTF-8' | wc -l

In case the number of lines is different make sure to encode and declare ``UTF-8`` as encoding. To find out which exact files have wrong declaration of encoding try to execute the following:

:: 

  grep --include \*_lang.php -r 'charset' "$ESHOP_PATH/source/modules/$MODULE_NAME/" | grep -v -i 'UTF-8'

BOM
^^^

As described in `PSR-1`_ "Files MUST use only UTF-8 **without BOM** for PHP code.". The following command will show all ``UTF-8`` encoded files which have BOM embedded at the beginning of the file. In order to pass this criteria the output of given command should be empty.

::
  
  (cd "$ESHOP_PATH/source/modules/$MODULE_NAME/" && find . -type f -regex ".*/.*\.\(php\|tpl\|sql\)" -exec file "{}" \; | grep 'with\ BOM')

In case there are files with embedded BOM one could try and use the following command to remove it:

::

  tail --bytes=+4 with_bom.php > without_bom.php

3. Adjust for BC breaks in PHP versions
---------------------------------------

At the moment this topic is not automated thus one has to manually look at all recent BC breaking changes which are described in the following documents:

* `BC breaking changes from PHP 5.3 to 5.4`_
* `BC breaking changes from PHP 5.4 to 5.5`_
* `BC breaking changes from PHP 5.5 to 5.6`_

4. Adjust removed functionality
-------------------------------

At the moment this topic is not automated thus one has to follow the list of removed functionality at `OXID eShop v6.0.0 changelog`_ and apply necessary changes.

5. Adjust your database code to the new DB Layer
------------------------------------------------

New classes are used
^^^^^^^^^^^^^^^^^^^^

All OXID eShop `BC classes`_ were deprecated and a new database interface was introduced. These changes requires one to update the class name which is used for database access. The following commands will try to compare the number of lines which represents old database classes (``oxDb``) used in old version of module versus number of new classes (``DatabaseProvider``) in module being ported (*ideally the numbers should match*):

::
  
  grep --include \*.php -r 'oxDb' "$ESHOP_PATH/source/modules/$OLD_MODULE_NAME/" | wc -l
  grep --include \*.php -r 'DatabaseProvider' "$ESHOP_PATH/source/modules/$MODULE_NAME/" | wc -l

**Note**: It's quite possible that line numbers wouldn't match in case new database related statements were added.

Old classes removed
^^^^^^^^^^^^^^^^^^^

Just as a safety measure, let's make sure that old classes (``oxDb``) are not present in the ported module (*output should be empty*):

::
  
  grep --include \*.php -r 'oxDb' "$ESHOP_PATH/source/modules/$MODULE_NAME/"

Evaluate possible BC breaking changes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Starting with the release of OXID eShop `v6.0.0`_ there are some BC breaking changes for database ``select`` and ``selectLimit`` methods. The changes are described with more detail at `Quick guide to port a module for OXID eShop version 6.0`_. Use the following line to locate any usages of the above mentioned methods inside the module:

::
  
  grep --include \*.php -r -i -P "\-\>\s*?(select|selectLimit)\s*?\(" "$ESHOP_PATH/source/modules/$OLD_MODULE_NAME/"

In case the mentioned methods are found please apply the necessary changes as it's described in `Quick guide to port a module for OXID eShop version 6.0`_ (*"Stick to database interfaces" topic*).

6. Adjust the code style of your modules code
---------------------------------------------

Adjust code sniffer settings
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Initially OXID eShop code sniffer settings are adjusted to scan only the OXID eShop core files thus it requires some changes in order to be able to run against given module. The following line will update code sniffer settings which would not ignore module files anymore:

::

  sed -i '/modules/d' "$ESHOP_PATH/vendor/oxid-esales/coding-standards/Oxid/ruleset.xml"

Run code sniffer
^^^^^^^^^^^^^^^^

Given command will trigger the execution of OXID eShop code sniffer against provided module. In order to pass the criteria the output should be empty:

::

  (cd "$ESHOP_PATH" && vendor/bin/phpcsoxid "source/modules/$MODULE_NAME/")

In case the output is not empty, please follow the given messages and apply the necessary changes.

7. Replace BC Layer classes
---------------------------

BC layer classes
^^^^^^^^^^^^^^^^

Starting from OXID eShop `v6.0.0`_ a `BC layer`_ was introduced, which allows old modules to work with the updated OXID eShop core. `BC layer`_ is a collection of class aliases which maps old OXID eShop classes (e.g. `oxArticle`) into new namespaced classes (e.g. `OxidEsales\Eshop\Application\Model\Article`). Keep in mind that the solution is temporary and is included to allow for an easy transition into the new OXID eShop version. All these `BC classes`_ are considered as deprecated thus it's highly recommended to replace old classes with the namespaced equivalents.

**Note**: Before proceeding with the commands below please make sure you have have your environment variables prepared (`ESHOP_PATH` and `MODULE_NAME`).
**Note**: After execution of automated replace for `BC classes`_ it might happen that the alignment of variables within comment blocks are broken thus it might be a good idea to re-run code style check.

In order to automate the replacing of `BC classes`_ consider using the following command which will create a script responsible for PHP file update at ``/tmp/bc_change.php``:

::

  cat << 'EOF' > /tmp/bc_change.php
  <?php
  count($argv) > 1 || die("File name missing!\n"); $filename = $argv[1];
  file_exists($filename) || die("Given file '$filename' does not exist!\n");
  getenv('ESHOP_PATH') || die("Please define 'ESHOP_PATH' environment variable!\n");
  $bcMapFilename = getenv('ESHOP_PATH') . '/source/Core/Autoload/BackwardsCompatibilityClassMap.php';
  file_exists($bcMapFilename) || die("BC class layer map missing, please make sure file '$bcMapFilename' is available!\n");

  $bcMap = array_map(function($value) { return '\\' . $value; }, require($bcMapFilename));
  $contents = file_get_contents($filename);

  $methodsWithFirstArgumentAsBcClass = ['oxNew', '::set', '::get', 'resetInstanceCache', 'getComponent', 'getMock', 'assertInstanceOf', 'setExpectedException', 'prophesize'];
  $phpdocTags = ['var', 'param', 'return', 'mixin', 'throws', 'see'];

  preg_match_all('/[^\S\n]*use[^\S\n]+[\w\\\\]*?(?P<class>\w+)[^\S\n]*;/i', $contents, $matches);
  $bcMapKeysToIgnore = $matches['class'];
  foreach ($bcMapKeysToIgnore as $class) {
    unset($bcMap[strtolower($class)]);
  }

  foreach ($bcMap as $bcClass => $nsClass) {
    $replaceMap = [
      '/\b((' . implode('|', $methodsWithFirstArgumentAsBcClass) . ')\s*\(\s*)["\']' . $bcClass . '["\']/i' => "$1$nsClass::class",
      '/\b(new\s+)' . $bcClass . '\b(\s*[;\()])/i' => "$1$nsClass$2",
      '/\b(catch\s+\(\s*)' . $bcClass . '(\s+\$)/i' => "$1$nsClass$2",
      '/(\@\b(' . implode('|', $phpdocTags) . ')(\s+|\s+\S+\s*\|\s*))' . $bcClass . '\b/i' => "$1$nsClass",
      '/\b(class\s+\w+\s+extends\s+)[\\\\]?' . $bcClass . '\b/i' => "$1$nsClass",
      '/\b(instanceof\s+)' . $bcClass . '\b/i' => "$1$nsClass",
      '/(?<!\\\\)\b' . $bcClass . '(\s*::\s*\$?\w+)/i' => "$nsClass$1",
      '/(?<!\\\\)\b' . $bcClass . '(\s+\$\w+\s*[,\)])/i' => "$nsClass$1",
      '/\buse\s+\\\\' . $bcClass. '\s*;/i' => "",
    ];

    $contents = preg_replace(array_keys($replaceMap), array_values($replaceMap), $contents);
  }

  $contents && file_put_contents($filename, $contents) || die("There was an error while executing 'preg_replace'!\n");
  EOF

In order to apply the above script for all PHP files inside a module consider using the following command snippet:

::

  (cd "$ESHOP_PATH/source/modules/$MODULE_NAME/" && find . -type f -regex ".*/.*\.\php" | cut -c 3- ) | while read MODULE_FILE_NAME; do
    echo "Processing file: $MODULE_FILE_NAME";

    php /tmp/bc_change.php "$ESHOP_PATH/source/modules/$MODULE_NAME/$MODULE_FILE_NAME"
  done

Unfortunately it's not possible to automate every case of `BC classes`_ replacement. To be able to manually evaluate every ambiguous `BC class`_ usage consider using the following snippet:

::

  BC_CLASS_PAIRS=$(cat "$ESHOP_PATH/source/Core/Autoload/BackwardsCompatibilityClassMap.php" | grep '=>' | sed 's/\\\\/\\/g')
  BC_CLASS_LIST=$(echo "$BC_CLASS_PAIRS" | sed -r 's/.*'\''(\w+)'\''.*/\1/g')
  BC_CLASS_LIST_PIPED=$(echo "$BC_CLASS_LIST" | paste -sd "|" | sed -r 's/(.*)/\(\1\)/')
  BC_CLASS_SEARCH_PATTERN='(?<bc_match_quotes>"|'"'"'|)\b(?<!\$|\/|=|-|_|{|\?|\`|\*|:|\[|\.|,|\\|="|='"'"'|<|>|\(|\))('$BC_CLASS_LIST_PIPED')(?!\$|\/|=|-|_|}|\?|\`|\*|:|\]|\.|,|->|\\|>|<|@|\(|\))\b\k<bc_match_quotes>|(?<!\\)(?<bc_skip_quotes>["'"'"']).*?(?<!\\)\k<bc_skip_quotes>(*SKIP)(?!)|\w*(\/\*\*|\*|\/\/|\#).*(*SKIP)(?!)'
  SEARCH_FILE_LIST=$(find "$ESHOP_PATH/source/modules/$MODULE_NAME/" -type f -iregex '.*/.*\.\(php\|tpl\)' -not -iregex '.*/metadata\.php')
  echo "$SEARCH_FILE_LIST" | xargs -n1 grep --color=always -iP -H -n "$BC_CLASS_SEARCH_PATTERN"

In case there are a lot of entries to evaluate please consider using a pager as following:

::

  echo "$SEARCH_FILE_LIST" | xargs -n1 grep --color=always -iP -H -n "$BC_CLASS_SEARCH_PATTERN" | less -r

In case there are a lot of false positive results within given test suites consider skipping the evaluation for these files:

::

  SEARCH_FILE_LIST_WO_TESTS=$(find "$ESHOP_PATH/source/modules/$MODULE_NAME/" -type f -iregex '.*/.*\.\(php\|tpl\)' -not -iregex '.*/metadata\.php' -not -iregex '.*Test\.php' -not -iregex '.*/tests/.*')
  echo "$SEARCH_FILE_LIST_WO_TESTS" | xargs -n1 grep --color=always -iP -H -n "$BC_CLASS_SEARCH_PATTERN"

In order to pass the given porting criteria please replace every found old BC class usage into the namespaced one. Consider using `BC class map`_ as a guide to know which class to replace into.

8. Installable via composer
---------------------------

In order to pass this porting criteria one has to update given module to be compatible with `composer`_. Please consider following a document on the subject: `How to make OXID eShop module installable via composer?`_

9. Introduce a namespace in your module
---------------------------------------

In order to pass this porting criteria one has to register a namespace in ``composer.json`` file as it is also mentioned in the previous guide of "`How to make OXID eShop module installable via composer?`_". In addition to this few modifications to ``metadata.php`` file has to be applied as well. All the necessary modifications are described in sub-topics written below. 

Metadata version
^^^^^^^^^^^^^^^^

The ``sMetadataVersion`` variable in ``metadata.php`` file has to be changed to have at least version ``2.0`` which indicates the usage of namespaced classes. In order to quickly verify the version, consider using the following command:

::

  grep -i -P "sMetadataVersion\s*?=\s*?'2\.0'" "$ESHOP_PATH/source/modules/$MODULE_NAME/metadata.php"

In case of a negative result, please update the value of ``sMetadataVersion`` variable.

`files` field
^^^^^^^^^^^^^

Starting from metadata version ``2.0`` the ``files`` section is obsolete due to the fact that composer takes care of autoloading for these files through registered namespace.

Consider looking at the list of files which were included in the old version of given module:

::

  grep "'files'" "$ESHOP_PATH/source/modules/$OLD_MODULE_NAME/metadata.php"

Make sure each of these listed files are now under their own namespace. Please use the information provided in the PHP manual in order to be able to `register a class under the namespace`_. As an end result there should not be any entries left for the `files` section in the new module, consider using the following command to quickly double check the status (*should be empty*):

::

  grep "'files'" "$ESHOP_PATH/source/modules/$MODULE_NAME/metadata.php"

`extend` field
^^^^^^^^^^^^^^

Starting from metadata version ``2.0`` the ``extend`` section expects UNS OXID eShop classes as keys and module namespaced classes as values (*Previously `BC classes`_ were used as keys and file path as value*). To list all ``extend`` entries from an old module consider using the following command:

::

  grep -Pzo '(?s)extend.*?\)' "$ESHOP_PATH/source/modules/$OLD_MODULE_NAME/metadata.php"

Make sure each of these used module classes are now registered under their own namespace. Please use the information provided in the PHP manual in order to be able to `register a class under the namespace`_.
Consider using the following commands in order to visually compare changes:

::

  grep -Pzo '(?s)extend.*?\)' "$ESHOP_PATH/source/modules/$OLD_MODULE_NAME/metadata.php"
  grep -Pzo '(?s)extend.*?[\)\]]' "$ESHOP_PATH/source/modules/$MODULE_NAME/metadata.php"

To get a better understanding consider this visual example from `oxid-esales/paypal-module`_ of above mentioned changes:

* Using older metadata:

::

  'order' => 'oe/oepaypal/controllers/oepaypalorder',
  'oxorder' => 'oe/oepaypal/models/oepaypaloxorder',

* Using new metadata:

::

  \OxidEsales\Eshop\Application\Controller\OrderController::class => \OxidEsales\PayPalModule\Controller\OrderController::class,
  \OxidEsales\Eshop\Application\Model\Order::class => \OxidEsales\PayPalModule\Model\Order::class,

`controllers` field
^^^^^^^^^^^^^^^^^^^

As it's described in :ref:`V2 metadata details <metadata_version2-20170427>` please make sure that all keys in `controllers` field are written in lowercase:

::
  
  grep -Pzo '(?s)controllers.*?[\)\]]' "$ESHOP_PATH/source/modules/$MODULE_NAME/metadata.php"

Namespaced classes
^^^^^^^^^^^^^^^^^^

At this step it's still quite possible that few of module classes might not have been namespaced yet. In order to make sure that this is indeed not the case consider using the following commands to verify number of classes (*Old classes vs namespace entries, ideally they should match*):

::

  grep --include \*.php -r '^class' "$ESHOP_PATH/source/modules/$OLD_MODULE_NAME" | wc -l
  grep --include \*.php -r '^namespace' "$ESHOP_PATH/source/modules/$MODULE_NAME" | wc -l

If for some reason test classes should not be included, consider using the following:

::

  grep --include \*.php --exclude \*Test.php -r '^class' "$ESHOP_PATH/source/modules/$OLD_MODULE_NAME" | wc -l
  grep --include \*.php --exclude \*Test.php -r '^namespace' "$ESHOP_PATH/source/modules/$MODULE_NAME" | wc -l

**Note**: It's quite possible that due to refactoring or addition of new classes the numbers above will not match.

Short array syntax
^^^^^^^^^^^^^^^^^^

Starting with new OXID eShop version the lowest supported PHP version is 5.6, which means there is no reason to keep the old long syntax of arrays anymore. Consider using the following command to quickly check if there are any old long array syntax usages left (*ideally the result should be empty*):

::

  grep -i 'array' "$ESHOP_PATH/source/modules/$MODULE_NAME/metadata.php" | wc -l

As a reminder please see quick visual difference between `old and new notation of arrays`_.

Documentation
-------------

List of documentation which explores module porting process with more details:

* `Steps to port a module for the OXID eShop version 6.0`_
* `Quick guide to port a module for OXID eShop version 6.0`_
* `Guide to make a full port of a module for OXID eShop version 6.0`_
* `How to make OXID eShop module installable via composer?`_
* :ref:`V2 metadata details <metadata_version2-20170427>`
* `Module structure`_

.. _v6.0.0: https://github.com/OXID-eSales/oxideshop_ce/tree/v6.0.0
.. _oxid-esales/paypal-module: https://github.com/OXID-eSales/paypal
.. _oxid-esales/testing-library: https://github.com/OXID-eSales/testing_library
.. _PSR-1: http://www.php-fig.org/psr/psr-1/
.. _official OXID eShop VM: https://github.com/OXID-eSales/oxvm_eshop
.. _BC classes: https://github.com/OXID-eSales/oxideshop_ce/blob/v6.0.0/source/Core/Autoload/BackwardsCompatibilityClassMap.php#L12-L572
.. _BC class: `BC classes`_
.. _BC class map: `BC classes`_
.. _composer: https://getcomposer.org
.. _Quick guide to port a module for OXID eShop version 6.0: https://oxidforge.org/en/how-to-quickly-port-a-module-to-oxid-eshop-6-0.html
.. _Steps to port a module for the OXID eShop version 6.0: https://docs.oxid-esales.com/developer/en/6.0/update/eshop_from_53_to_6/modules.html
.. _BC layer: https://docs.oxid-esales.com/developer/en/6.0/update/eshop_from_53_to_6/modules.html
.. _Guide to make a full port of a module for OXID eShop version 6.0: https://oxidforge.org/en/how-to-fully-port-a-module-to-oxid-eshop-6-0.html
.. _register a class under the namespace: http://php.net/manual/en/language.namespaces.rationale.php
.. _Module structure: https://docs.oxid-esales.com/developer/en/6.0/modules/developing/structure.html
.. _system requirements: https://docs.oxid-esales.com/eshop/de/6.0/installation/neu-installation/server-und-systemvoraussetzungen.html
.. _old and new notation of arrays: http://php.net/manual/en/language.types.array.php
.. _OXID eShop v6.0.0 changelog: https://oxidforge.org/en/oxid-eshop-v6-0-0-beta1-detailed-code-changelog.html
.. _How to make OXID eShop module installable via composer?: https://docs.oxid-esales.com/developer/en/6.0/modules/module_via_composer.html
.. _BC breaking changes from PHP 5.3 to 5.4: http://php.net/manual/en/migration54.incompatible.php
.. _BC breaking changes from PHP 5.4 to 5.5: http://php.net/manual/en/migration55.incompatible.php
.. _BC breaking changes from PHP 5.5 to 5.6: http://php.net/manual/en/migration56.incompatible.php
