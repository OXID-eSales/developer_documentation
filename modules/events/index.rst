Events
======

The version 6.2 of the OXID eShop introduces events as
an additional way to enhance the functionality of the
shop. On certain occasions - for example, when a model
object is stored to the database - an event is sent out.
This event may have a payload, for example the object
that is stored to the database.

Project or module developers may register an event
subscriber that may react on the event. The most simple
use case for this is logging the event. But there are
far more interesting things that can may be done,
notably manipulating the payload of the event.
So in the example above the subscriber may check if
it is an order that is saved and then check the
creditworthiness of the ordering person and set
the order to some special state if this person is
not creditworthy.

.. Note::

  Using events is a much more secure way to
  enhance shop functionality than the traditional
  way of enhancing classes. While methods in
  the core code may be deprecated and the code
  refactored, the events should stay the same
  over a much longer period of time. So to keep
  you shop upgradable, you should use events
  whereever possible.

The framework used for this is the Symfony
event handling mechanism. So general information
may be found in the
`Symfony Documentation <https://symfony.com/doc/3.4/event_dispatcher.html>`_.

Symfony support two ways of registering events,
the listener and the subscriber model.
We advise you to use the subscriber model to
register your events, because this is the advanced
way. You write a subscriber class that implements
the `EventSubscriberInterface` and register this
class with the `kernel.event_subscriber` tag in
the DI container.

An example may be found here: :ref:`event_example`.

.. Important:: 

  **Make module event subscribers shop aware**
    
  If you want to use event subscribers in a
  module that may not be activated in all
  subshops of a project, you should make your
  subscribers shop aware. Then they will only
  be called for shops where the module is
  activated in. Otherwise the will be called
  regardless of the shop active.
	
  This is easily
  done: Just inherit from
  `AbstractShopAwareEventSubscriber` and you
  are done. If this is for some reasons
  not possible because you need to inherit
  from some other parent class, there is
  also a trait you may use:
  `ShopAwareServiceTrait`. Just include it
  in your class. 

Available events
----------------

.. toctree::
    :titlesonly:
    :glob:
    :maxdepth: 2

    ModuleEvents/index
    DatabaseEvents/index
    DIContainerEvents/index
    ViewEvents/index
    ShopGeneralEvents/index