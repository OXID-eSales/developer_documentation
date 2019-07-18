Autoloading Of Classes
======================

Currently shop has three autoloaders registered: Composer autoloader,
Backwards Compatibility Autoloader and Module Autoloader. They are registered in exactly this order
in the file :file:`bootstrap.php`.

General workflow
----------------

If you request a class, then first the Composer autoloader is asked, after that the Backwards Compatibility Autoloader
and in the end the Module Autoloader:

.. uml::

    @startuml
    start
    :<b>Composer Autoloader</b>;
       if (is there a autoload section in a composer.json?) then (true)
           :Load class according composer.json autolaod section;
           stop
       else (false)
           :<b>Backwards Compatibility Autoloader</b>;
           -->
           if (class can be resolved to the unified namespace equivalent class) then (true)
               :trigger Compsoer Autoloader;
               stop
           else (false)
               :<b>Module Autoloader</b>;
               if (class found in module metadata files array?) then (true)
                   :Load class from path defined in metadata;
                   stop
               else (false)
                   if (class found in module metadata extends array?) then (true)
                       :Create extension chains;
                       stop
                   else (false)
                       :Loads any other registered autoloader or a
                       Class not found fatal error is thrown;
                       stop
                   endif
               endif
           endif
       endif
    @enduml

Composer Autoloader
^^^^^^^^^^^^^^^^^^^

It is the first autoloader in line and tries to autoload all namespaced
classes, which are configured in the root :file:`composer.json` file
or child :file:`composer.json` files. An example of a class which would be
resolved by this autoloader is ``OxidEsales\Eshop\Application\Model\Article``.

Backwards Compatibility Autoloader
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Its purpose is to autoload all deprecated shop classes which are defined in the file
:file:`Core/Autoload/BackwardsCompatibilityAutoload.php`. This is not a real autoloader:
If a backwards compatibility class from :file:`Core/Autoload/BackwardsCompatibilityAutoload.php` is requested,
this autoloader searches the Unified Namespace equivalent of the backwards compatible
class and hands the request over to the Composer autoloader. If you request e.g. the backwards
compatiblity class ``oxArticle``, this autoloader would resolve the class to its unified namespace equivalent
``OxidEsales\Eshop\Application\Model\Article`` and trigger the composer autoloader.

Module Autoloader
~~~~~~~~~~~~~~~~~

This autoloader is responsible for loading module classes (defined in
metadata as module files and extensions). It first checks if given class
exists in any of active modules module file. If so - this class is
included and it stops here. If not - it tries to check whether it is an
extension of any active module, as modules can extend other module
classes. This is also the case when extension is created via
``new ExtendedClass`` instead of ``oxNew``, and as ExtendedClass\_parent
class does not exist, it has to be created at this point.
