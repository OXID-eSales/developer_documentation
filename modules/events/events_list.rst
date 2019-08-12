Events List
===========

**FinalizingModuleActivationEvent**

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\Module\Setup\Event\FinalizingModuleActivationEvent

This event will be dispatched at the last step of the module activation for a specific shop.

Usage example: run some module database migrations.

**FinalizingModuleDeactivationEvent**

Namespace:

.. code-block:: php

    OxidEsales\EshopCommunity\Internal\Module\Setup\Event\FinalizingModuleDeactivationEvent

This event will be dispatched at the last step of the module deactivation for a specific shop.

.. attention::

    Module might be still active in another shop.

Usage example: clean-up some module related data from the database.

**BeforeModuleDeactivationEvent**

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\Module\Setup\Event\BeforeModuleDeactivationEvent

This event will be dispatched right before the module deactivation for a specific shop.

.. attention::

    Module might be still active in another shop.

Usage example: clean-up some module related data from the database.

**BeforeModelUpdateEvent**

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\ShopEvents\BeforeModelUpdateEvent

This event will be dispatched before model state is changed in database.
Takes the model object as constructor argument.

.. code-block:: php

    /**
     * @param \OxidEsales\Eshop\Core\Model\BaseModel $model Model class object
     */
    public function __construct(\OxidEsales\Eshop\Core\Model\BaseModel $model)
    {
        $this->model = $model;
    }

Usage example: reverse proxy (varnish) can use this event to handle caching.


**BeforeModelDeleteEvent**

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\ShopEvents\BeforeModelDeleteEvent

This event will be dispatched before model is deleted from database.
Takes the model object as constructor argument.

.. code-block:: php

    /**
     * @param \OxidEsales\Eshop\Core\Model\BaseModel $model Model class object
     */
    public function __construct(\OxidEsales\Eshop\Core\Model\BaseModel $model)
    {
        $this->model = $model;
    }

Usage example: reverse proxy (varnish) can use this event to handle caching.


**AfterModelInsertEvent**

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\ShopEvents\AfterModelInsertEvent

This event will be dispatched after the model data is inserted to database.
Takes the model object as constructor argument.

.. code-block:: php

    /**
     * @param \OxidEsales\Eshop\Core\Model\BaseModel $model Model class object
     */
    public function __construct(\OxidEsales\Eshop\Core\Model\BaseModel $model)
    {
        $this->model = $model;
    }

Usage example: reverse proxy (varnish) can use this event to handle caching.


**AfterModelUpdateEvent**

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\ShopEvents\AfterModelUpdateEvent

This event will be dispatched after the model data is updated in database.
Takes the model object as constructor argument.

.. code-block:: php

    /**
     * @param \OxidEsales\Eshop\Core\Model\BaseModel $model Model class object
     */
    public function __construct(\OxidEsales\Eshop\Core\Model\BaseModel $model)
    {
        $this->model = $model;
    }

Usage example: reverse proxy (varnish) can use this event to handle caching.


**AfterModelDeleteEvent**

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\ShopEvents\AfterModelDeleteEvent

This event will be dispatched after the model data is deleted from database.
Takes the model object as constructor argument.

.. code-block:: php

    /**
     * @param \OxidEsales\Eshop\Core\Model\BaseModel $model Model class object
     */
    public function __construct(\OxidEsales\Eshop\Core\Model\BaseModel $model)
    {
        $this->model = $model;
    }

Usage example: reverse proxy (varnish) can use this event to handle caching.


**ViewRenderedEvent**

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\ShopEvents\ViewRenderedEvent

This event will be dispatched after the shop has rendered the current
page for output. Before this event is sent, all processing of the current request
needs to be finished. The event takes the shopcontrol object as constructor argument.

.. code-block:: php

    /**
     * @param \OxidEsales\Eshop\Core\ShopControl $shopControl ShopControl object
     */
    public function __construct(\OxidEsales\Eshop\Core\ShopControl $shopControl)
    {
        $this->shopControl = $shopControl;
    }

Usage example: reverse proxy (varnish) uses this event to set its cookies and decide if
reverse proxy functionality should be used for this response or not.


**BasketChangedEvent**

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\ShopEvents\BasketChangedEvent

This event will be dispatched when the basket was changed. It takes the basket component object
as a constructor argument.

.. code-block:: php

    /**
     * @param \OxidEsales\Eshop\Application\Component\BasketComponent $basketComponent Basket component
     */
    public function __construct(\OxidEsales\Eshop\Application\Component\BasketComponent $basketComponent)
    {
        $this->basketComponent = $basketComponent;
    }

Usage example: reverse proxy (varnish) can use this event to decide if parts of cache need to be invalidated.


**BeforeHeadersSendEvent**

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\ShopEvents\BeforeHeadersSendEvent

This event will be dispatched before the shop sends the headers.
The event takes the shopcontrol and current view object as constructor argument.

.. code-block:: php

    /**
     * @param \OxidEsales\Eshop\Core\ShopControl               $shopControl ShopControl object
     * @param \OxidEsales\Eshop\Core\Controller\BaseController $controller  Controller
     */
    public function __construct(
        \OxidEsales\Eshop\Core\ShopControl $shopControl,
        \OxidEsales\Eshop\Core\Controller\BaseController $controller
    ) {
        $this->shopControl = $shopControl;
        $this->controller = $controller;
    }

NOTE: modules should only register headers in

.. code-block:: php

    \OxidEsales\Eshop\Core\Registry::get(\OxidEsales\Eshop\Core\Header::class);

but leave actual sending of headers to shop.

Usage example: reverse proxy (varnish) uses this event to set its cookies and decide if
reverse proxy functionality should be used for this response or not.


**ApplicationExitEvent**

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\ShopEvents\ApplicationExitEvent

This event will be dispatched when the shop is preparing for emergency exit.

NOTE: modules should only register headers in

.. code-block:: php

    \OxidEsales\Eshop\Core\Registry::get(\OxidEsales\Eshop\Core\Header::class);

but leave actual sending of headers to shop.

Usage example: reverse proxy (varnish) can use this event to ensure all headers and cookies needed by the module
are in place for the next request.


**AllCookiesRemovedEvent**

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\ShopEvents\AllCookiesRemovedEvent

This event will be dispatched after the shop called the cookie removal method. For example in case of cookienote decline,
shop has to remove all cookies.

Usage example: reverse proxy (varnish) can use this event to remove module specific cookies as well.


**ShopConfigurationChangedEvent**

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\Adapter\Configuration\Event\ShopConfigurationChangedEvent

This event will be triggered when shop configuration was changed in database.
It takes the configuration variable name and shop id the data was changed for as constructor argument.

.. code-block:: php

    /**
     * @param string $configurationVariable Config varname.
     * @param int    $shopId                Shop id.
     */
    public function __construct(string $configurationVariable, int $shopId)
    {
        $this->configurationVariable = $configurationVariable;
        $this->shopId = $shopId;
    }

Usage example: reverse proxy (varnish) can use this event to invalidate parts of cache depending on places
affected by configuration change.


**SettingChangedEvent**

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\Module\Setting\Event\SettingChangedEvent

This event will be triggered when shop module settings have been changed in database.
It takes the configuration variable name, shop id and module string (prefixed like used in oxconfig.oxmodule)
as constructor arguments.

.. code-block:: php

    /**
     * @param string $configurationVariable Config varname.
     * @param int    $shopId                Shop id.
     * @param string $module                Module information as in oxconfig.oxmodule
     */

Usage example: reverse proxy (varnish) can use this event to invalidate parts of cache depending on places
affected by configuration change.


**ThemeSettingChangedEvent**

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\Theme\Event\ThemeSettingChangedEvent

This event will be triggered when theme settings have been changed in database.
It takes the configuration variable name, shop id and theme string (prefixed like used in oxconfig.oxmodule)
as constructor arguments.

.. code-block:: php

    /**
     * @param string $configurationVariable Config varname.
     * @param int    $shopId                Shop id.
     * @param string $theme                 Theme information as in oxconfig.oxmodule
     */

Usage example: Modules can use this event to invalidate parts of cache depending on places
affected by configuration change.


**BeforeSessionStartEvent**

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\ShopEvents\BeforeSessionStartEvent

This event will be dispatched by shop to inform services that session is about to be started.

Usage example: reverse proxy (varnish) can use this event to set the required session cache limiter.


**AfterRequestProcessedEvent**

Namespace:

.. code-block:: php

    Namespace: OxidEsales\EshopCommunity\Internal\ShopEvents\AfterRequestProcessedEvent

This event will be dispatched by shop to inform services that a request has been processed.

Usage example: reverse proxy (varnish) can use this event to execute cache before shop redirects.


**ConfigurationErrorEvent**

**ProjectYamlChangedEvent**

Namespace:

.. code-block:: php

	Namespace: OxidEsales\EshopCommunity\Internal\Application\Events
	
This event will be dispatched after the generated services file for the DI container changed.
This happens for example when a module, that has its own `services.yaml` file, is activated.

Usage example: Reset the DI container when the `generated_services.yaml` file changes (there
is probably no other use case).

**ModuleSetupEvent**