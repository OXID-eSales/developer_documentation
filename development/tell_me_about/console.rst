Console
=======

OXID eShop uses `Symfony console component <https://symfony.com/doc/current/console.html>`__ to register or execute command, so it's possible to use
it's features.

Executing CLI Commands
----------------------

To get list of commands, execute:

.. code:: bash

    ./vendor/bin/oe-console

In case you are using Enterprise Edition subshops feature, to get list of specific subshop commands, execute:

.. code:: bash

    ./vendor/bin/oe-console --shop-id=<shop-id>

.. note::

    If <shop-id> will not be defined: shop 1, going to be used.

Some other commands examples:

.. code:: bash

    ./vendor/bin/oe-console oe:module:activate <module-id>
    ./vendor/bin/oe-console oe:module:activate <module-id> --shop-id=<shop-id>
    ./vendor/bin/oe-console oe:module:deactivate <module-id> --shop-id=<shop-id>

Creating custom CLI commands
----------------------------

.. note::
    Watch a short video tutorial on YouTube: `Custom Console Commands <https://www.youtube.com/watch?v=7CvBUpR44YM>`_.

Commands can be created for :doc:`OXID eShop modules </development/modules_components_themes/module/index>` and for :doc:`OXID eShop components </development/modules_components_themes/component>`.

Module commands
^^^^^^^^^^^^^^^

OXID eShop allows to create commands for modules. Commands will appear in the list only when a module is active.

Creating a command class
""""""""""""""""""""""""

First of all it's necessary to create a command class.

|example|

.. code:: php

    <?php declare(strict_types=1);

    namespace OxidEsales\DemoModule\Command;

    use Symfony\Component\Console\Command\Command;
    use Symfony\Component\Console\Input\InputInterface;
    use Symfony\Component\Console\Output\OutputInterface;

    class HelloWorldCommand extends Command
    {
        protected function configure(): void
        {
            $this->setName('demo-module:say-hello')
                ->setDescription('"Hello world" command.')
                ->setHelp('Command says "Hello world".');
        }

        protected function execute(InputInterface $input, OutputInterface $output): int
        {
            $output->writeln('Hello world!');

            return Command::SUCCESS;
        }
    }

Registering a command file
""""""""""""""""""""""""""

When a command file is created, it's necessary to register it as a service. If `services.yaml` file is not present,
create it in your module root directory.

.. important::

    Do not add a leading backslash to the classname.

    wrong: `class: \\OxidEsales\\DemoModule\\Command\\HelloWorldCommand`

    correct: `class: OxidEsales\\DemoModule\\Command\\HelloWorldCommand`

.. code:: yaml

    services:
      OxidEsales\DemoModule\Command\HelloWorld:
        class: OxidEsales\DemoModule\Command\HelloWorldCommand
        tags:
          - { name: 'console.command' }

Now after module activation, command will be available in commands list and it can be executed via:

.. code:: bash

    ./vendor/bin/oe-console demo-module:say-hello

In case you need to change command name, it can be done also via `services.yaml` file by adding `command` entry:

.. code:: yaml

    services:
      OxidEsales\DemoModule\Command\HelloWorld:
        class: OxidEsales\DemoModule\Command\HelloWorldCommand
        tags:
          - { name: 'console.command', command: 'demo-module:say-hello-another-command' }

And again after module activation command can be called via:

.. code:: bash

    ./vendor/bin/oe-console demo-module:say-hello-another-command

Demo module with command example can be found `here <https://github.com/OXID-eSales/module-template/blob/b-7.1.x/src/Logging/Command/ReadLogsCommand.php>`__.

OXID eShop component commands
-----------------------------

Component commands works similarly as module commands, just one difference, they become active instantly after
installation via composer. For more information refer to
:doc:`OXID eShop component </development/modules_components_themes/component>`.

Command class
^^^^^^^^^^^^^

Component command example:

.. code:: php

    <?php declare(strict_types=1);

    namespace OxidEsales\DemoComponent\Command;

    use Symfony\Component\Console\Command\Command;
    use Symfony\Component\Console\Input\InputInterface;
    use Symfony\Component\Console\Output\OutputInterface;

    class HelloWorldCommand extends Command
    {
        protected function configure(): void
        {
            $this->setName('demo-component:say-hello')
                ->setDescription('Says hello.')
                ->setHelp('This command welcomes you.');
        }

        protected function execute(InputInterface $input, OutputInterface $output): int
        {
            $output->writeln('Hello World!');

            return Command::SUCCESS;
        }
    }

.. important::

    Component command must extend `Symfony\\Component\\Console\\Command\\Command`.

Command file registration
^^^^^^^^^^^^^^^^^^^^^^^^^

When command class is created, it's necessary to register it as a service. If the `services.yaml` is not present,
create it in your component root directory.

.. code:: yaml

    services:
      OxidEsales\DemoComponent\Command\HelloWorld:
        class: OxidEsales\DemoComponent\Command\HelloWorldCommand
        tags:
          - { name: 'console.command' }

Command testing
---------------

For integration testing commands we recommend to use the symfony CommandTester_. Within this CommandTester the input and output can even be overwritten for your needs.

.. _CommandTester: https://symfony.com/doc/current/console.html#testing-commands

Example for executing your command within command tester:

.. code:: php

    class TestCommand extends Command
    {
        protected function configure(): void
        {
            $this->setName('oe:tests:test-command');
        }

        protected function execute(InputInterface $input, OutputInterface $output): int
        {
            $output->writeln('Command has been executed!');

            return Command::SUCCESS;
        }
    }

.. code:: php

    public function testCommandExecution(): void
    {
        $commandTester = new CommandTester(new TestCommand());

        $commandTester->execute([]);

        $output = $commandTester->getDisplay();

        $this->assertSame('Command has been executed!' . PHP_EOL, $output);
    }
