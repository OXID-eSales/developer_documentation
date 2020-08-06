How to use events
=================

There are three steps:

1. Choosing the event(s) you want to subscribe to
2. Writing the event subscriber
3. Registering the event subscriber in the DI container

Choosing the event(s)
---------------------

First you need to find the event you want to react to. Look in the different
sections here in the developer documentation which event(s) you want to subscribe
to.

For our example here we chose two events, the `AfterModelInsertEvent` and the
`AfterModelUpdateEvent`. What we want to do is to write a log entry every time
a new model object is saved or updated in the database.

Writing the subscriber
----------------------

We want our subscriber class `ModelLoggerEventSubscriber` to be
shopaware, that means, it should be only triggered in sub shops
where the module, in which this event subscriber is implemented,
is activated. To achieve this, we inherit from
`AbstractShopAwareEventSubscriber`.

The constructor of the subscriber expects a PSR compatible
logger and the method `logDatabaseActivity()` writes
the information to the logfile by using the injected PSR logger.
It takes the event as a parameter from which we can extract the
payload of the event, in this case the model object is saved
to the database. What the payload of the event is and what methods
you may expect depends on each event, so consult the documentation /
the event code what you may get here.

The method `getSubscribedEvents()` returns an associative array where the event
names are the keys and the method name in the subscriber is the value
that is called. It is the convention for OXID events to have a
class name with namespace as name of the event. In our example here we
use for both events the same handler method, but there could also be
a different method for each event. This is completely up to you.

.. code-block:: php

  namespace OxidEsales\Eventexample;

  use OxidEsales\EshopCommunity\Internal\Framework\Event\AbstractShopAwareEventSubscriber;
  use OxidEsales\EshopCommunity\Internal\Transition\ShopEvents\AfterModelInsertEvent;
  use OxidEsales\EshopCommunity\Internal\Transition\ShopEvents\AfterModelUpdateEvent;
  use Psr\Log\LoggerInterface;
  use Symfony\Component\EventDispatcher\Event;

  class ModelLoggerEventSubscriber extends AbstractShopAwareEventSubscriber
  {

    /** @var LoggerInterface */
    private $logger;

    public function __construct(LoggerInterface $logger)
    {
        $this->logger = $logger;
    }

    public function logDatabaseActivity(Event $event)
    {
        $model = $event->getModel();
        $id = "unknown";
        try {
            $id = $model->getId();
        } catch (\Exception $e) {
            // pass
        }

        $this->logger->info("Saved object of type " . get_class($model) . " with id " . $id);

    }

    public static function getSubscribedEvents()
    {
        return [AfterModelUpdateEvent::class => 'logDatabaseActivity',
                AfterModelInsertEvent::class => 'logDatabaseActivity'];
    }
  }
 
Registering the event subscriber
--------------------------------

Just add a `services.yaml` file to your module. This file should
look like this for our example:

.. code-block:: yaml

  services:

    _defaults:
      public: false
      autowire: true

    OxidEsales\Eventexample\ModelLoggerEventSubscriber:
      class: OxidEsales\Eventexample\ModelLoggerEventSubscriber
      tags: ['kernel.event_subscriber']
      
The `_defaults` section is not strictly necessary since there is
only one service defined. But normally you module would have
several services so it makes sense to introduce a defaults section
and mark all services as private and that they should be auto-wired.
This is also the default for OXID service definitions, so make it
a habit to include this in all your `services.yaml` files also.

Then there is the quite simple service definition. We use the
class path of the subscriber as key for the service. In principle
we could have used any string, but it is also good practice to
use something truly unique, so the fully qualified class name
is a good choice (if there would be a unique interface, it would
even be better, but since every event subscriber implements the
same interface this is not a good choice here).

And then there is the class and the tag that qualifies this service
as an event subscriber. That's all. Instantiating the class, injecting
the logger and calling the event handler method is all handled by
the Symfony DI container, when this event is announced in the
OXID eShop.
