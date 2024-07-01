General information
===================

.. note::
    Watch a short video tutorial on YouTube: `Event Subscribers <https://www.youtube.com/watch?v=53oAt0mGH9U>`_.

Events are an additional way to enhance the functionality of the
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
  where ever possible.

The framework used for this is the Symfony
event handling mechanism. So general information
may be found in the
`Symfony Documentation <https://symfony.com/doc/current/event_dispatcher.html>`_.

Symfony support two ways of registering events,
the listener and the subscriber model.
We advise you to use the subscriber model to
register your events, because this is the advanced
way. You write a subscriber class that implements
the `EventSubscriberInterface` and register this
class with the `kernel.event_subscriber` tag in
the DI container.
