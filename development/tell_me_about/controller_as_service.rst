Controller as a Service
=======================

Since version 7.3 it's possible to register OXID controllers as services in the Dependency Injection Container (DIC).
The registration occurs in :file:`services.yaml`, similarly to other services, and it is possible to register
such controller-services for components, modules or projects.

Unlike traditional controllers, new controllers initialization is performed by DIC without calling `oxNew` function,
also it's impossible to extend such controllers with `oxNew`/`extend` section of module's :file:`metadata.php`

.. note::

    For modules it's an alternative way to register controllers, if you register a controller as a service you should
    not do it again with :file:`metadata.php`.

Controller Class
----------------

New service controllers are very similar to standard controllers, they must extend
`OxidEsales\EshopCommunity\Core\Controller\BaseController` or
implement `OxidEsales\EshopCommunity\Internal\Framework\Controller\ControllerInterface`.

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

You can register your controller in a :file:`service.yaml` of your module, component or project.
Controller service visibility must be declared as public and its description contain special controller tags:

    - `name: "oxid.controller"`
    - `controller_key: "some-unique-controller-key"`

`controller_key` must contain a unique value because it will be used to identify you controller by 'cl' parameter in URL,
similar to other OXID controllers.

|example|

.. code:: yaml

      MyModule\MyModuleController:
        tags:
          - { name: 'oxid.controller', controller_key: 'my_controller_key' }
        public: true

following this example, we should be able to call our controller via the following URL:

    .. code::

        https://<shop-url>/index.php?cl=my_controller_key

.. important::

    All dependant services which you want to use in your service controllers MUST be instantiated by DIC using constructor or
    setter injection, don't try to fetch them from the Container using `ContainerFacade`, `ContainerFactory` and similar.

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

    Bad example:

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
But you can decorate them like any other service,
please check `symfony documentation <https://symfony.com/doc/current/service_container/service_decoration.html>`__
to find out more.

.. note::

    Because each Controller Decorator must implement
    `OxidEsales\EshopCommunity\Internal\Framework\Controller\ControllerInterface`,
    you may find yourself creating a lot of boilerplate code, when trying to change only one method's behaviour.
    Instead, make your decorator inherit from
    `OxidEsales\EshopCommunity\Internal\Framework\Controller\AbstractControllerDecorator`.
    This approach will help make your decorators smaller and they will contain code only for methods
    that you really want to modify.

For example, if you want to decorate only `init()` function:

|example|

.. code:: php

    namespace MyModule;

    use OxidEsales\EshopCommunity\Internal\Framework\Controller\AbstractControllerDecorator;
    use OxidEsales\EshopCommunity\Internal\Framework\Controller\ControllerInterface;

    class ControllerAsServiceDecorator extends AbstractControllerDecorator
    {
        public function __construct(protected readonly ControllerInterface $originalController)
        {
        }

        public function init()
        {
            $this->doSomethingExtra();
            // and don't forget to call original method!
            $this->originalController->init();
        }
    }

Then register your decorator in a :file:`service.yaml`, remember that decorators must be `public`:

|example|

.. code:: yaml

      MyModule\ControllerAsServiceDecorator:
        decorates: Oxid\ControllerAsService
        arguments: [ '@.inner' ]
        public: true
