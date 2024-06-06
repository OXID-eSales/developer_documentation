Database Configuration
======================

.. _Singe DB:

Working with a single database server
-------------------------------------

To configure you DB connection, simply combine connection parameters into a database URL (DSN)
(see `Connecting using a URL <https://www.doctrine-project.org/projects/doctrine-dbal/en/current/reference/configuration.html#connecting-using-a-url>`__ for reference)
and put it in the env file for your target environment, e.g.:

  .. code:: text

      # .env.dev.local
      OXID_DB_URL=mysql://my-user:my-pass@my-server:3306/my-db-name?charset=utf8&driverOptions[1002]="SET @@SESSION.sql_mode=\"\""

Using Database replication
--------------------------

Replication can be enabled and configured:

- via environment variables:

  .. code:: text

      # .env.local
      OXID_DB_URL=mysql://my-user:my-pass@primary-server:3306/my-db-name?charset=utf8&driverOptions[1002]="SET @@SESSION.sql_mode=\"\""
      OXID_DB_REPLICATE=1
      OXID_DB_REPLICA_URLS=["mysql:\/\/my-user-1:my-pass-1@replica-server-1:3306\/my-db-name?charset=utf8&driverOptions[1002]=\"SET @@SESSION.sql_mode=\\\"\\\"\"","mysql:\/\/my-user-2:my-pass-2@replica-server-2:3306\/my-db-name?charset=utf8&driverOptions[1002]=\"SET @@SESSION.sql_mode=\\\"\\\"\""]

.. note::
    Here ``OXID_DB_REPLICA_URLS`` is a `JSON encoded <https://www.php.net/manual/en/function.json-encode.php>`__  array
    of strings with replica connection URLs.

- or by overriding the Symfony Service Container parameters directly:

  .. code:: yaml

      # var/configuration.dev/parameters.yaml
      oxid_esales.db.url: 'mysql://my-user:my-pass@primary-server:3306/my-db-name?charset=utf8&driverOptions[1002]="SET @@SESSION.sql_mode=\"\""'
      oxid_esales.db.replicate: true
      oxid_esales.db.replicas:
        - 'mysql://my-user-1:my-pass-1@replica-server-1:3306/my-db-name?charset=utf8&driverOptions[1002]="SET @@SESSION.sql_mode=\"\""'
        - 'mysql://my-user-2:my-pass-2@replica-server-2:3306/my-db-name?charset=utf8&driverOptions[1002]="SET @@SESSION.sql_mode=\"\""'


.. note::
    Note that the same variable ``OXID_DB_URL``, that was introduced in :ref:`Singe DB`,
    will determine the connection URL for the primary server, when used in replication context.

.. warning::
    Although it's possible to configure and use the same database access credentials across all the primary and replica servers,
    it's advised to create a separate account that has privileges only for the replication process,
    to minimize the possibility of compromise to other accounts.
    (see more in `Creating a User for Replication <https://dev.mysql.com/doc/refman/8.4/en/replication-howto-repuser.html>`__.)
