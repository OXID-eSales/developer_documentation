*************************************************
Using Symfony DI container for shop customization
*************************************************

Introduction
############

Starting with version 6, the OXID framework incorporates the Symfony dependency injection (DI) container.
And it harbours a new namespace: :code:`OxidEsales\EshopCommunity\Internal`.
As the name `"Internal"` indicates, these classes should not be extended in modules.
And the DI container was also intended only for internal use.

But these new things are part of a refactoring strategy to move the traditional OXID framework to some more standard ways of building a PHP application.
Currently the stuff in the Internal namespace is not really interesting for module or project developers, because it is mostly about framework.
But in the future we also want to move parts of the traditional OXID business logic into this namespace.
And then it will be of concern for module and project developers.

There is one very strict rule governing this Internal namespace:
The traditional way of altering or enhancing code (chain extending classes via modules and instantiating them with
:code:`oxNew()`) won't work anymore.

Instead there are several mechanisms to extend core functionality using the DI container and thus moving to more common used procedures.
The purpose of this document is to describe these mechanisms.

The first prerequisite for this is opening the usage of the DI container also for module and project developers.
There are some quirks regarding the use of the Symfony DI container within OXID,
so the first section deals with what you can do and what you can't do within a module.
The following document describes the mechanisms that are in place and that go beyond default behaviour of Symfony DI.

DI for module developers
########################

It is quite easy to register your own services that you have implemented for your module.
Just put a file named :code:`services.yaml` in the root directory of your module and on activating the module,
the information in this file will be used when the DI container is generated.

There is one obvious problem with this approach.
In a multi shop environment you activate a module not for the whole installation, but for a certain shop.
So your services are active in every shop.
But this is not really a problem:
None of the services that come with the shop knows about the services you module provides.
You need at least one entry point in the traditional OXID way,
that is the extension of a shop class that will be instantiated with :code:`oxNew()`.
From this class you will call your services.
And since :code:`oxNew()` will only instantiate your class in shops where the module is active,
your services will not be called since your extension of the entry point class will not be active.

Now the next question is:

**How do I get my services in the entry point classes of my module?**

Imagine you have registered an enhanced version of the
:code:`Article` class in the shop and you want to get the price of the article from some external ERP system.

So first you design your service:

.. code:: php

    class ERPPriceProvider implements ERPPriceProviderInterface
    {
        public function getPrice(string $articleId, int $amount = 1)
        {
            // Do your stuff here.
            // You might use other services that you inject into this class.
        }
    }

Then you configure your service in the :code:`services.yaml` file of your module:

.. code:: yaml

    services:
        SomeCompany/SpecialERPModule/ERPPriceProviderInterface:
            class: SomeCompany/SpecialERPModule/ERPPriceProvider
            autowire: true
            public: true

.. note:: We prefer at OXID to use the interface of the service class as the DI container key for the service.

Now you make your own :code:`Article` class where you overwrite the :code:`getPrice()` method:

.. code:: php

    class ERPArticle extends Article_parent
    {
        public function getPrice($amount = 1)
        {
            $container = ContainerFactory::getInstance()→getContainer();
            $erpService = $container→get(ERPPriceProviderInterface::class);
            return $erpService->getPrice($this->getId(), $amount)
        }
    }

You just fetch the DI container via the :code:`ContainerFactory` and then fetch your service.
In order to obtain the service, it needs to be defined as **public**.
That's it.

.. warning:: Purely internal services of you module that are only used in other services via injection should be defined with **public: false**.


**Now, what will you do to extend services that are defined by the eShop core?**

The simple solution could have just been to **subclass** and reconfigure it in your module's
:code:`services.yaml` file.
Then your version of the service would be used and not the one from the core?
But this **won't work**!
If several modules would subclass the same core service, the last module would "win" - this is not what you would expect.
That's the reason why we forbid such a thing - if you try it out, you will get an exception.

**So what about the other way round?**

What if you extend the core service in the traditional way by **chain extending** it and registering it in the
:code:`metadata.php` file of you module?
This is also **not possible**, because the services are instantiated by the DI container builder
and this container won't use :code:`oxNew()`!
So obviously you are stuck.

But there are solutions, that will be described in the next section.

New ways of enhancing business logic
####################################

Using events
************

This is the cool thing about using the Symfony DI container.
You may register event subscribers and when the shop core runs certain things, it triggers an **event**.
And if you have registered an event **subscriber** for the event, you will get **notified** and can do cool stuff.

The obvious advantage is, several modules may register for the same event without the fear that one of them may not be called
(`well, events themselves may stop the event calling chain, but then it is intentionally`).

At the moment there are only very few events that are triggered by core services,
but that's due to the fact, that the stuff in the
:code:`Internal` namespace is mostly framework stuff that is of no concern for module and project developers.

The more we will refactor stuff from the traditional code into the
:code:`Internal` namespace, the more the list of events will grow.

.. note:: Look up the Symfony documentation for more info on events.

Except on thing, as we mentioned above, your code may run in a **multi shop environment**.
And when activating a module for one shop, the events in the
:code:`services.yaml` file would always be triggered,
regardless if the event handler was activated for just one shop or all shops.

.. _tutorial_shop_aware_events:

**So how to make sure, that your event handler is only called on activated shops?**

Normally you implement the
:code:`EventSubscriberInterface` from Symfony to make you service an event handler.
For multi-shop configurations we have an additional interface called
:code:`ShopAwareInterface`. When a service implements this interface, the handler will only be called for activated shops.

You don't need to (and should not) implement this interface yourself, but use the
:code:`AbstractShopAwareEventSubscriber` class as parent class of your event subscriber.

Then your subscriber will automatically only be called for shops where your module is activated for.

In case you can't inherit from this class (because you use another parent class), there is also a trait called
:code:`ShopAwareServiceTrait` that you may use. Just don't forget to say that your subscriber class implements the
:code:`ShopAwareInterface`.
And that's all for you to make your event subscribers work in a multi shop environment!


What's happening in the background is that on activating the module, in a
:code:`generated_project.yaml` file your event subscriber will be reconfigured.
It will then know on which shops it is activated and the Symfony event dispatcher will use this information
to decide whether to call the subscriber or not.

.. warning:: This also means that you should not manually alter the **generated_project.yaml** file but leave it to the OXID module framework to maintain this file!

Enhancing without events
************************

**But what can you do if there is no event that suits you purpose and you really need to alter or enhance the behaviour of some internal services?**

There is an easy solution! Besides the
:code:`generated_project.yaml` file, discussed in the previous section, you may also create a
:code:`configurable_project.yaml` file.

In this file you may substitute every core service you want to change, with your own implementation.

Since there is only one instance of this configuration file there won't arise any conflicts.

**But this file is on a project level, not on a module level?**

But obviously, you can put the services that you reference in this file into a
:code:`composer package` for reuse (`actually we recommend this`) so that only the configuration file is in your project folder.

This then gives you complete flexibility - with one caveat:
This is **not shop-aware**!
So if you want to make your alteration just for a specific shop in a multi shop environment,
you have to handle this by **yourself in your code**.

This flexibility comes with a price tag:
We won't guarantee that our service implementations stay the same.
So if you write your alternative implementation by subclassing our services,
there might be problems when you update to a newer shop version.

.. warning:: There will be no deprecation procedure for implementations in the Internal namespace!

The only thing that we guarantee to keep **stable** are the **public interfaces**.
Only for these we promise a deprecation procedure that gives you time for adjusting your extensions.

Interfaces that are marked
:code:`@internal` may change without notice as do all implementations in the Internal namespace.

.. note:: This does not mean that you can't do this, and actually the risk is quite small since we tend to adhere to the single responsibility principle for service classes.
    But you have to balance the possibility of trouble on updates with your needs for really overwriting stuff.
    We decided to do this because this allows us to work more flexible in the future and provide you with improved solutions much faster.
    So rely on our public interfaces to be stable, but our implementations to be more fluid than in the past.

Enhancing data objects
**********************

In the traditional OXID framework it was quite easy to add columns to a database table
and use these in the model objects due to the usage of **active records** - the new columns would just show up in the object!

Within the
:code:`Internal` namespace, active records **will not be used** anymore!

.. note:: The architecture is **layered** with business logic mostly in services that are managed by the DI container.
    These services are **stateless**, while data is moved around in so called data objects.
    And these data objects are **not managed by the DI container**.
    Instead they are (`at least regarding persistent data`) managed by a certain service type, the so called
    **data access objects (DAOs)**. These again use **mapper classes** to map data from the database to data objects and vice versa.

Since the Internal namespace uses DI to instantiate services it would be quite simple to
enhance the DAO or mapper classes to accommodate for **additional columns**.

**But what about the data objects themselves?**

They are not instantiated through the DI container, so it is difficult to add new getters and setters.
For this problem there is a solution in the OXID eShop starting with version 6.2.

Where there are DAOs that return data objects that are of interest for project developers,
a **special mechanism** is in place to enhance the data objects dynamically through the
:code:`services.yaml` file in a module.

Check, if the DAO in question implements the
:code:`DynamicDataObjectDaoInterface`,
then you may enhance the data objects managed by this DAO simply by configuring the additional object properties.
The syntax is quite easy!

You need a special section in your
:code:`services.yaml` file called
:code:`oxid_dataobject_extension`.
that expects an array of configuration dictionaries.

The entry with the key
:code:`daokey` expects the key of the DI container, the DAO is bound to.
All other entries are interpreted as database columns, so your configuration looks roughly like this:

.. code:: yaml

    oxid_dataobject_extension:
    - {
        daokey: <the DI container key for the DAO>,
        <columnname1>: <type>,
        <columnname2>: <type>
      }
    - {
        daokey: <the DI container key for the DAO>,
        <columnname1>: <type>,
        <columnname2>: <type>
      }


Supported data types:
 * int,
 * float,
 * bool,
 * string
 * timestamp (treated as string).

.. warning:: The DAO has a **create()** method for instantiating the object
    that should **always** be called for creating new data objects;
    using this method ensures, that the object is correctly instantiated
    and has the setters and getters for the columns, configured in the module.
