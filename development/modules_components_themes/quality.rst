Development quality tools and requirements
==========================================

To ensure the quality of your solutions, follow the OXID eSales code requirements.

Goals
-----

* Ensure security to avoid

    * our customers’ data integrity being compromised, and sensitive information being exposed
    * lawsuits
    * harm to our credibility and brand
* Minimize downtimes, bugs and issues to avoid that customers

    * develop mistrust in our product
    * search for more reliable solutions from competitors
* Improve productivity by writing clean code that

    * avoids the accumulation of technical obstacles
    * does not rely on unstable features of our dependencies

Main requirements
-----------------

Ensure your solution meets the following requirements:
* Your code supports all PHP versions listed for the used OXID eShop version.
* You have properly structured your code:

    * Where possible, use dependency injection through constructors instead of direct/static calls to classes.
    * Implement all main functionality as services to be accessed via Dependency Injection (DI).
    * Split services into easy to understand, small testable units.

* You have thoroughly tested your code.
* All files use ``strict_types`` flag.
* A Readme file in the root directory of your solution describes:

    * which requirements and compatibilities are to be met
    * how to install your solution for development purposes
    * how to install your solution for production
    * how to run the solution tests and other tools

Reuse requirements
------------------

When reusing shop extended classes and shop methods, follow the rules below:

* Hook to shop events in place of direct extension if possible.
* To not destroy a module chain, ensure that extended shop/module classes call parent methods.
* Do not use deprecated methods.
* When adding new methods, consider prefixing them with your company abbreviation to not conflict with other modules in chain.

For more information about reusing and creating shop modules and themes, see the `Developer Documentation <https://docs.oxid-esales.com/developer/en/latest/development/modules_components_themes/index.html>`_.


Code quality requirements
-------------------------

Quality is everyone’s responsibility. High quality is one of the main goals throughout the development process.

Observe the following quality criteria:

* Your tests cover at least 80% of the functionality.
* You use the correct test type:

    * Test service units by performing unit tests with PHPUnit.
    * Test the component integration by performing integration tests with PHPUnit in a separate directory.
    * Test the frontend workflow chains by performing acceptance tests using a User Acceptance Test Framework.
* Your code’s C.R.A.P index is below 30.
* Your code’s methods cyclomatic complexity is below 10.
* Your code style meets the PSR-12 standard (for more information, see `php-fig.org/psr/psr-12 <https://www.php-fig.org/psr/psr-12/>`_).

Tools requirements
------------------

To meet our standards, ensure your solution has easy to run, preconfigured, quality tools as development dependencies.

We strongly recommend using the following ones (or alternatives):

* PHP_CodeSniffer using PSR-12, to ensure your code is PSR-12-compliant (`github.com/squizlabs/PHP_CodeSniffer <https://github.com/squizlabs/PHP_CodeSniffer>`_)
* PHP Mess Detector (`phpmd.org <https://phpmd.org/>`_)
* A static analysis tool, for example one of the following:

    * PHPStan: To ensure your code achieves level 5 or higher
    * Psalm: To ensure your code achieves level 4 or lower

You can use the mentioned technology easily via composer, as described, for example, in our `module template <https://github.com/OXID-eSales/module-template/blob/3f9b27d99bfb327521db8282bba92631ea103deb/composer.json#L45>`_.

With :code:`composer static`, run the PHP_CodeSniffer, PHPMess Detector and PHPStan with one single command, with the associated configurations.

Using productivity tools
------------------------

OXID eSales recommends the following productivity tools:

* Sonarcloud
* Github Actions

Sonarcloud
^^^^^^^^^^

Use Sonarcloud as a final report point for psalm issues, code coverage reports, code duplications analysis.

Integrate Sonarcloud in your CI-process, for example in Github Actions, as described in our `module-template <https://github.com/OXID-eSales/module-template/blob/3f9b27d99bfb327521db8282bba92631ea103deb/.github/workflows/development.yml#L493>`_.

Github Actions
^^^^^^^^^^^^^^

Use Github Actions with all required tools integrated to run them constantly during development.

Store all required files in your repository in the :file:`.github/workflows` folder.

A good example can be found in our module template under `workflows <https://github.com/OXID-eSales/module-template/tree/b-7.0.x/.github/workflows>`_.

Split the files in :file:`development.yml`, :file:`trigger.yml`, and :file:`schedule.yml`.

The `development.yml <https://github.com/OXID-eSales/module-template/blob/b-7.0.x/.github/workflows/development.yml>`_ defines the executable jobs and the possible options for them.

If you want a reusable workflow, for example to use it in our :file:`trigger.yml` or :file:`schedule.yml, make sure that :code:`on:` contains :code:`workflow_call:` with the possible parameters.

To be able to execute this workflow on Github on the `Actions tab <https://github.com/OXID-eSales/module-template/actions/workflows/development.yml>`_, make sure that :code:`on:` contains :code:`workflow_dispatch:` with the values to be passed.

Both examples can be seen in the :file:`development.yml` file.

.. important::
    If you want to execute the workflow on the :guilabel:`Actions` tab, add the :code:`workflow_dispatch` value in the main-branch as well. Otherwise the :file:`development.yml` file isn't visible.


Use the `trigger.yml <https://github.com/OXID-eSales/module-template/blob/b-7.0.x/.github/workflows/trigger.yml>`_ file to trigger a process on specific events, defined under

.. code:: yaml

    on:
      pull_request:
      push:

With these events, the jobs will be triggered and execute, for example, the jobs in the :file:`development.yml` file with specific parameters. The possible parameters are defined in the :file:`development.yml` file and need to be passed in the jobs defined in the :file:`trigger.yml`.

Use the `schedule.yml <https://github.com/OXID-eSales/module-template/blob/b-7.0.x/.github/workflows/schedule.yml>`_ file to trigger scheduled jobs. If you want to execute jobs every week or month, put them in the :file:`schedule.yml`.

To define multiple scheduled jobs, create multiple files, fpr example :file:`monthly.yml` and :file:`weekly.yml`.

In our :file:`schedule.yml` file, see how to define the execution time:

.. note::
    As cron syntax, use the `POSIX cron syntax <https://pubs.opengroup.org/onlinepubs/9699919799/utilities/crontab.html#tag_20_25_07>`_.

.. code:: yaml

    on:
      schedule:
        - cron: '0 0 */7 * *'


Following best practices
------------------------

* Ensure that all new code goes through the review process of at least one other team member.
* Follow Test Driven Development (TDD) principles.
* Compose meaningful commit messages.
  |br|
  Good commit messages describe the changes applied in the commit, “ESDEV-1111 Fix the tracking system issue“, for example.
