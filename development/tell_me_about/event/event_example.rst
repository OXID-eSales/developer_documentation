How to use events
=================

There are three steps:

1. Choosing the event(s) you want to subscribe to
2. Writing the event subscriber
3. Registering the event subscriber in the DI container

Choosing the event(s)
---------------------

First you need to find the event you want to react to. Look in the different sections here in the developer documentation which event(s) you want to subscribe to.

For our example here we chose two events, the `AfterModelInsertEvent` and the `AfterModelUpdateEvent`. What we want to do is to write a log entry every time a new model object is saved or updated in the database.

Writing the subscriber
----------------------

The `ModelLoggerEventSubscriber` subscriber class is very simple. It has a constructor, handler methods and one static method.

Let's begin with the constructor. The constructor expects a PSR compatible logger. Apart from that type hinting is always a good practice, we need it here explicitly because we want to autowire the logger in the DI container, so this type hint is necessary.

The next method `logDatabaseActivity` writes the information to the logfile by using the injected PSR logger. It takes the model as a parameter which is extracted from the payload of the event.

The method `logDatabaseActivity` is called by our handler methods `logDatabaseUpdate` and `logDatabaseInsert`. These methods are called if the corresponding event is triggered. As parameter they receive the individual event object from which we extract the
payload to pass it to our log method. In this case we extract the model object that is saved
to the database by using method `getModel`. What the payload of the event is and what methods you may expect depends on each event. Therefore consult the documentation or the event code what you may get here.

And last but not least there is this static method called `getSubscribedEvents`. This method is necessary to implement because it's used by the Symfony event dispatching mechanism. It returns an associative array where the event names are the keys and the value is the corresponding handler method name to call if the event gets triggered. It is the convention for OXID events that they have a static property `NAME` that provides the name of the event, so use this static property in `getSubscribedEvents`. In our example we use our handler method `logDatabaseUpdate` for the `AfterModelUpdateEvent` while the `AfterModelInsertEvent` is linked to the `logDatabaseInsert` method. The actual workflow - writing to the log - is transferred to our `logDatabaseActivity` method.

.. code-block:: php

  <?php declare(strict_types=1);
  namespace OxidEsales\EventExample;

  use Symfony\Component\EventDispatcher\EventSubscriberInterface;
  use OxidEsales\EshopCommunity\Internal\Transition\ShopEvents\AfterModelInsertEvent;
  use OxidEsales\EshopCommunity\Internal\Transition\ShopEvents\AfterModelUpdateEvent;
  use Psr\Log\LoggerInterface;
  use Symfony\Component\EventDispatcher\Event;

  class ModelLoggerEventSubscriber extends EventSubscriberInterface
  {
      /** @var LoggerInterface */
      private $logger;

      public function __construct(LoggerInterface $logger)
      {
          $this->logger = $logger;
      }

      private function logDatabaseActivity(Object $model)
      {
          $id = 'unknown';

          try {
              $id = $model->getId();
          } catch (\Exception $e) {
              // pass
          }

          $this->logger->info('Saved object of type ' . get_class($model) . ' with id ' . $id);
      }

      public function logDatabaseUpdate(AfterModelUpdateEvent $event)
      {
          $this->logDatabaseActivity($event->getModel());
      }

      public function logDatabaseInsert(AfterModelInsertEvent $event)
      {
          $this->logDatabaseActivity($event->getModel());
      }

      public static function getSubscribedEvents()
      {
          return [
              AfterModelUpdateEvent::NAME => 'logDatabaseUpdate',
              AfterModelInsertEvent::NAME => 'logDatabaseInsert',
          ];
      }
  }

Registering the event subscriber
--------------------------------

Just add a `services.yaml` file to your module. This file should look like this for our example:

.. code-block:: yaml

  services:

    _defaults:
      autowire: true

    OxidEsales\EventExample\ModelLoggerEventSubscriber:
      tags: ['kernel.event_subscriber']

The `_defaults` section is not strictly necessary since there is only one service defined. But often your module will have several services. Then it makes sense to introduce a defaults section. Event subscribers should never be called directly, but only by the event mechanism. Autowire should be `true` instead to enable the usage of autowiring in your event subscriber. In our example this is necessary to be able to autowire the logger service we want to use in our subscriber. This default definition is also the default for OXID services, so make it a habit to include this in all your `services.yaml` files also.

Then there is the quite simple service definition. We use the class path of the subscriber as key for the service. In principle we could have used any string, but it is also good practice to use something truly unique, so the fully qualified class name is a good choice. If there would be a unique interface, it would even be better, but due to every event subscriber implementing the same interface this is not a good choice here. Since we use our class namespace as service identifier, we do not need to specify any value for the `class` key which you probably have seen before in other service definitions where the interface namespace is used as an identifier. This makes our definition even more simple.

Last but not least what we need to add is the tag that qualifies this service as an event subscriber. That's all. Instantiating the class, injecting the logger and calling the event handler method is all handled by the Symfony DI container, when this event is triggered in the OXID eShop.
