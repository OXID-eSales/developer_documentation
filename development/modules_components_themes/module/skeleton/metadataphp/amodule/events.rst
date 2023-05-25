.. _metadataphpversion-events-20190911:

events
======

Description
    The specified event handler class should be registered in medatata files array.
Type
    associative array. Keys can be ``onActivate`` and ``onDeactivate``
Mandatory
    No
Example
     .. code:: php

         'events'       => [
            'onActivate'   => '\OxidEsales\PayPalModule\Core\Events::onActivate',
            'onDeactivate' => '\OxidEsales\PayPalModule\Core\Events::onDeactivate'
          ],

.. important::

    If you want to use your module services in the `onActivate` method the `ContainerFactory` should not be used for
    getting your services, because they aren't included in the container from the `ContainerFactory` during the activation
    process. You have to get a new container from the `ContainerBuilderFactory`. See an example below:

.. code:: php

    public static function onActivate(): void
    {
        $container = (new ContainerBuilderFactory())->create()->getContainer();
        $container->compile();

        $myService = $container->get('<service-id>');
        $myService->doSomething();
    }
