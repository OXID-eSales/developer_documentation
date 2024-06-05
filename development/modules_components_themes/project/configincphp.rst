Configuration file config.inc.php
=================================

The configuration file has been replaced by configuration environment variables and container parameters.

The table below displays the old parameters alongside their corresponding new parameters:

.. list-table::
   :header-rows: 1

   * - Old name (from config.php)
     - New name
     - Moved to
     - Type
   * - All DB parameters
     - OXID_DB_URL
     - environment parameters
     - string
   * - sCompileDir
     - OXID_BUILD_DIRECTORY
     - environment parameters
     - string
   * - sCompileDir
     - oxid_build_directory
     - container parameters
     - string
   * - sShopDir
     - oxid_shop_source_directory
     - container parameters
     - string
   * - sLogLevel
     - OXID_LOG_LEVEL
     - environment parameters
     - string
   * - sShopURL
     -
     - deleted
     -
   * - edition
     -
     - deleted
     -
   * - blDebugTemplateBlocks
     -
     - deleted
     -
   * - aRobotsExcept
     -
     - deleted
     -
   * - iDebugSlowQueryTime
     -
     - deleted
     -
   * - aSlaveHosts
     -
     - deleted
     -
   * - sAuthOpenIdRandSource
     -
     - deleted
     -
   * - deactivateSmartyForCmsContent
     -
     - deleted
     -
   * - iSmartyPhpHandling
     -
     - deleted
     -
   * - blDoNotDisableModuleOnError
     -
     - deleted
     -
   * - passwordHashingAlgorithm
     -
     - deleted
     -
   * - passwordHashingBcryptCost
     -
     - deleted
     -
   * - passwordHashingArgon2MemoryCost
     -
     - deleted
     -
   * - passwordHashingArgon2TimeCost
     -
     - deleted
     -
   * - passwordHashingArgon2Threads
     -
     - deleted
     -
