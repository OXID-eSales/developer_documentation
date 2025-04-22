Controller as a Service
=======================

As of OXID eShop version 7.3, you can register OXID controllers as services in the Dependency Injection Container (DIC).

The registration occurs in :file:`services.yaml`, similarly to other services, and it is possible to register
such controller services for components, modules or projects.

Unlike traditional controllers, the initialization of new controllers is performed by the DIC without calling the `oxNew` function.

Also, it’s impossible to extend such controllers using the `oxNew`/`extend` section in a module’s :file:`metadata.php` file.

Instead, consider using service decoration as described below.


.. note::

    For modules it's an alternative way to register controllers.

    If you register a controller as a service, do not register it again in :file:`metadata.php`.

Controller Class
----------------

New service controllers are very similar to standard controllers; they must extend
`OxidEsales\EshopCommunity\Core\Controller\BaseController` or
implement `OxidEsales\EshopCommunity\Internal\Framework\Controller\ViewControllerInterface`.

|example|

.. code:: php

    namespace MyModule;

    use OxidEsales\EshopCommunity\Core\Controller\BaseController;

    class MyModuleController extends BaseController
    {
        protected $_sThisTemplate = '@moduleId/my_module_controller';

        public function helloWorld(): void
        {
            echo 'Hello world!';
        }
    }

Service Registration
--------------------

Register your controller in a :file:`services.yaml` file of your module, component or project.

Controller service visibility must be declared as public and its description must contain special controller tags:

    - `name: "oxid.view_controller"`
    - `controller_key: "some-unique-controller-key"`

`controller_key` must contain a unique value because it will be used to identify your controller by the `cl` parameter in the URL,
similar to other OXID controllers.

|example|

.. code:: yaml

      MyModule\MyModuleController:
        tags:
          - { name: 'oxid.view_controller', controller_key: 'my_controller_key' }
        public: true

Following this example, we should be able to call our controller via the following URL:

    .. code:: text

       https://<shop-url>/index.php?cl=my_controller_key

.. important::

    All dependent services used in your service controllers MUST be instantiated by the DIC using constructor or setter injection.

    Avoid retrieving them directly from the Container using `ContainerFacade`, `ContainerFactory`, or similar patterns.

    Good example (constructor injection):

    .. code:: php

        class MyModuleController extends BaseController
        {
            public function __construct(
                private readonly ContextInterface $context
            ) {}

            public function helloWorld(): void
            {
                $this->context->...;
            }
        }

    Bad example (using ContainerFacade which is not recommended due to testing issues, for example):

    .. code:: php

        class MyModuleController extends BaseController
        {
            public function helloWorld(): void
            {
                $context = ContainerFacade::get(ContextInterface::class);
                $this->context->...;
            }
        }

Extending Controllers
---------------------

As we mentioned earlier, the standard `oxNew` extension method doesn't work for services.

But you can decorate them like any other service. For more information, see the `Symfony documentation <https://symfony.com/doc/current/service_container/service_decoration.html>`_.

.. note::

    Because each Controller Decorator must implement
    `OxidEsales\EshopCommunity\Internal\Framework\Controller\ViewControllerInterface`,
    you may find yourself creating a lot of boilerplate code when trying to change only one method's behavior.

    Instead, make your decorator inherit from
    `OxidEsales\EshopCommunity\Internal\Framework\Controller\AbstractControllerDecorator`.

    This approach will help make your decorators smaller and they will contain code only for methods
    that you really want to modify.

For example, if you want to decorate only the `init()` function:

|example|

.. code:: php

    namespace MyModule;

    use OxidEsales\EshopCommunity\Internal\Framework\Controller\AbstractControllerDecorator;
    use OxidEsales\EshopCommunity\Internal\Framework\Controller\ViewControllerInterface;

    class ControllerAsServiceDecorator extends AbstractControllerDecorator
    {
        public function __construct(protected readonly ViewControllerInterface $originalController)
        {
        }

        public function init()
        {
            $this->doSomethingExtra();
            // and don't forget to call original method!
            $this->originalController->init();
        }
    }

Then register your decorator in a :file:`services.yaml`, remember that decorators must be `public`.

|example|

.. code:: yaml

      MyModule\ControllerAsServiceDecorator:
        decorates: Oxid\ControllerAsService
        arguments: [ '@.inner' ]
        public: true
