<?php

/**
 * Copyright © OXID eSales AG. All rights reserved.
 * See LICENSE file for license details.
 */

$composerLock = file_get_contents('/var/www/composer.lock');
$data = json_decode($composerLock, true);

$excludes = [
    'oxid-esales/oxideshop-metapackage-ce',
    'oxid-esales/oxideshop-metapackage-pe',
    'oxid-esales/oxideshop-metapackage-ee',
    'oxid-esales/testing-library',
    'incenteev/composer-parameter-handler'
];

$repos = [];
$packages = [];

foreach ($data['packages'] as $package ) {
    $packages[$package['name']] = '"' . $package['name'] . '": "' . $package['version'] . '"';
    $repos[$package['name']] =
        '"' . $package['name'] . '": {' . PHP_EOL .
        '"type": "' . $package['source']['type'] . '",' . PHP_EOL .
        '"url": "' . str_replace('.git', '', $package['source']['url']) . '"' . PHP_EOL . '}';
}
foreach ($excludes as $key) {
    if(isset($repos[$key])) {
        unset($repos[$key]);
    }
    if(isset($packages[$key])) {
        unset($packages[$key]);
    }
}

$composer = '
{
  "name": "oxid-esales/oxideshop-project",
  "type": "project",
  "description": "Generated installation",
  "license": [
    "proprietary"
  ],
  "minimum-stability": "dev",
  "prefer-stable": true,
  "config": {
    "preferred-install": {
      "*": "dist"
    },
    "allow-plugins": {
        "ocramius/package-versions": true,
        "oxid-esales/oxideshop-composer-plugin": true,
        "oxid-esales/oxideshop-unified-namespace-generator": true
    }
  },
  "repositories": { 
    "0": {
            "type": "composer",
            "url": "https://enterprise-edition.packages.oxid-esales.com/"
        }, ' .
    implode(',' . PHP_EOL, $repos) .
    '},
   "require": {' .
    implode(',' . PHP_EOL, $packages).
    '}
   } ';

if ($decoded = json_decode($composer, true)) {
    file_put_contents(
        'generated_composer.json',
        json_encode($decoded, JSON_PRETTY_PRINT + JSON_UNESCAPED_SLASHES)
    );
} else {
    echo 'Broken json, please doublecheck';
}
