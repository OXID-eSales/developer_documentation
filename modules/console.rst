Console
=======

OXID eShop uses Symfony console component to register or execute command, so it's possible to use
it's features. More information about Symfony console can be found `here <https://symfony.com/doc/current/console.html>`__.

Executing CLI Commands
----------------------

To get list of commands, execute:

.. code:: bash

    vendor/bin/oe-console

In case you are using Enterprise Edition subshops feature, to get list of specific subshop commands, execute:

.. code:: bash

    vendor/bin/oe-console --shop-id=<shop-id>

.. note::

    If <shop-id> will not be defined: shop 1, going to be used.

Some other commands examples:

.. code:: bash

    vendor/bin/oe-console oe:module:activate <module-id>
    vendor/bin/oe-console oe:module:activate <module-id> --shop-id=<shop-id>
    vendor/bin/oe-console oe:module:deactivate <module-id> --shop-id=<shop-id>

Creating custom CLI commands
----------------------------

Commands can be created for OXID eShop modules or for OXID eShop components.

Module commands
^^^^^^^^^^^^^^^

OXID eShop allows to create commands for modules. Command will appear in the list only when module going to be activated.

Command class
"""""""""""""

First of all it's necessary to create a command class. Command class example:

.. code:: php

    <?php declare(strict_types=1);
    namespace OxidEsales\DemoModule\Command;

    use OxidEsales\EshopCommunity\Internal\Console\AbstractShopAwareCommand;
    use Symfony\Component\Console\Input\InputInterface;
    use Symfony\Component\Console\Output\OutputInterface;

    class HelloWorldCommand extends AbstractShopAwareCommand
    {
        protected function configure()
        {
            $this->setName('demo-module:say-hello')
            ->setDescription('"Hello world" command.')
            ->setHelp('Command says "Hello world".');
        }

        protected function execute(InputInterface $input, OutputInterface $output)
        {
            $output->writeln('Hello world!');
        }
    }

.. important::

    Module command must extend `\\OxidEsales\\EshopCommunity\\Internal\\Console\\AbstractShopAwareCommand`.
    It's necessary to extend this class otherwise command will not respect OXID eShop modules functionality and
    some features will not work.

Command file registration
"""""""""""""""""""""""""

When command file is created, it's necessary to register it as a service. If `services.yaml` file is not present,
create it in your module root directory.

.. code:: yaml

    services:
      oxid_esales.demo_component.command.hello_world:
        class: OxidEsales\DemoModule\Command\HelloWorldCommand
        tags:
        - { name: 'console.command' }

Now after module activation, command will be available in commands list and it can be executed via:

.. code:: bash

    vendor/bin/oe-console demo-module:say-hello

In case you need to change command name, it can be done also via `services.yaml` file by adding `command` entry:

.. code:: yaml

    services:
      oxid_esales.demo_component.command.hello_world:
        class: OxidEsales\DemoModule\Command\HelloWorldCommand
        tags:
        - { name: 'console.command', command: 'demo-module:say-hello-another-command' }

And again after module activation command can be called via:

.. code:: bash

    vendor/bin/oe-console demo-module:say-hello-another-command

Demo module with command example can be found `here <https://github.com/OXID-eSales/logger-demo-module>`__.

OXID eShop component commands
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Component commands works similarly as module commands, just one difference, they become active instantly after
installation via composer.

How is it works
""""""""""""""""

On installation the OXID composer plugin will include your components :file:`services.yaml` file in a file
named :file:`generated_services.yaml` that is read when the DI container is assembled.
You will find this file in var/generated, ``but you should not alter it manually``.

.. important::

    You can't overwrite the definition of services that are already defined in the container
    in your components :file:`services.yaml` file. The composer plugin will not include your
    file if you try to do this. Because if several components would override the same definition,
    It would be completely arbitrary which component would win, depending on the sequence of the installation.


Component type
""""""""""""""

It's necessary that component would have `oxideshop-component` type in `composer.json` file:

.. code:: json

    {
        //...
        "type": "oxideshop-component",
        //...
    }

Command class
"""""""""""""

Component command example:

.. code:: php

    <?php declare(strict_types=1);
    namespace OxidEsales\DemoComponent\Command;

    use Symfony\Component\Console\Command\Command;
    use Symfony\Component\Console\Input\InputInterface;
    use Symfony\Component\Console\Output\OutputInterface;

    class HelloWorldCommand extends Command
    {
        protected function configure()
        {
            $this->setName('demo-component:say-hello')
            ->setDescription('Says hello.')
            ->setHelp('This command welcomes you.');
        }

        protected function execute(InputInterface $input, OutputInterface $output)
        {
            $output->writeln('Hello World!');
        }
    }

.. important::

    Component command must extend `\\Symfony\\Component\\Console\\Command\\Command`.

Command file registration
"""""""""""""""""""""""""

When command class is created, it's necessary to register it as a service. If the `services.yaml` is not present,
create it in your component root directory.

.. code:: yaml

    services:
      oxid_esales.demo_component.command.hello_world:
        class: OxidEsales\DemoComponent\Command\HelloWorldCommand
        tags:
        - { name: 'console.command' }

Overwriting system services
"""""""""""""""""""""""""""

You can overwrite system services very easily in your project, you need to do this manually.
For this purpose there is a file named :file:`configurable_services.yaml`,
that you will find (or can create) under :file:`var/configuration`. This file exists exactly once per project.
This is only safe way to overwrite system services.

.. important::

    We do not recommend overwrite system services in internal directory,
    Unless services have ``@stable`` annotation, interfaces or implementations might change
    in future releases For more information refer to :file:`README.md` file in internal directory.

    So we propose a better way to enhance the shop functionality to
    use :doc:`events </modules/events/general>`.
    This is a much more update friendly way to enhance a shop.