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

    use OxidEsales\EshopCommunity\Internal\Framework\Console\AbstractShopAwareCommand;
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

    Module command must extend `\\OxidEsales\\EshopCommunity\\Internal\\Framework\\Console\\AbstractShopAwareCommand`.
    It's necessary to extend this class otherwise command will not respect OXID eShop modules functionality and
    some features will not work.

Command file registration
"""""""""""""""""""""""""

When command file is created, it's necessary to register it as a service. If `services.yaml` file is not present,
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
        - { name: 'console.command', command: 'demo-module:say-hello' }
        
.. important::

    Despite specifying `command: 'demo-module:say-hello'` explicitly is not needed, we highly recommend to do so,
    because you will likely run into `this issue <https://stackoverflow.com/a/61655652/2123108>`__ otherwise.

Now after module activation, command will be available in commands list and it can be executed via:

.. code:: bash

    vendor/bin/oe-console demo-module:say-hello

In case you need to change command name, it can be done also via `services.yaml` file by adding `command` entry:

.. code:: yaml

    services:
      OxidEsales\DemoModule\Command\HelloWorld:
        class: OxidEsales\DemoModule\Command\HelloWorldCommand
        tags:
        - { name: 'console.command', command: 'demo-module:say-hello-another-command' }

And again after module activation command can be called via:

.. code:: bash

    vendor/bin/oe-console demo-module:say-hello-another-command

Demo module with command example can be found `here <https://github.com/OXID-eSales/logger-demo-module>`__.

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
^^^^^^^^^^^^^^^^^^^^^^^^^

When command class is created, it's necessary to register it as a service. If the `services.yaml` is not present,
create it in your component root directory.

.. code:: yaml

    services:
      OxidEsales\DemoComponent\Command\HelloWorld:
        class: OxidEsales\DemoComponent\Command\HelloWorldCommand
        tags:
        - { name: 'console.command', command: 'demo-module:say-hello' }

Command testing
---------------

For integration testing commands we recommend to use the symfony CommandTester_. Within this CommandTester the input and output can even be overwritten for your needs.

.. _CommandTester: https://symfony.com/doc/current/console.html#testing-commands

Example for executing your command within command tester:

.. code:: php

	class TestCommand extends Command
	{
	    protected function configure()
	    {
		$this->setName('oe:tests:test-command');
	    }

	    protected function execute(InputInterface $input, OutputInterface $output)
	    {
		$output->writeln('Command has been executed!');
		return 0;
	    }
	}

	public function testCommandExecution()
	{
	    $commandTester = new CommandTester(new TestCommand());

	    $commandTester->execute([]);

	    $output = $commandTester->getDisplay();

	    $this->assertSame('Command has been executed!' . PHP_EOL, $output);
	}



