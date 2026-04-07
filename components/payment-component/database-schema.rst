Database Schema
===============

The payment component provides the following tables:

oe_payments_contract
--------------------

.. list-table::
   :header-rows: 1
   :widths: 25 20 55

   * - Column
     - Type
     - Description
   * - ``OXID``
     - VARCHAR(32)
     - Contract ID
   * - ``OXSHOPID``
     - INT
     - Shop ID
   * - ``OXUSERID``
     - VARCHAR(32)
     - Customer ID
   * - ``OXORDERID``
     - VARCHAR(32)
     - Order ID (after commit)
   * - ``OXSTATUS``
     - VARCHAR(32)
     - Contract status
   * - ``OXBASKETDATA``
     - TEXT
     - Basket snapshot (JSON)
   * - ``OXCAPTUREDAMOUNT``
     - DOUBLE
     - Captured amount
   * - ``OXREFUNDEDAMOUNT``
     - DOUBLE
     - Refunded amount
   * - ``OXTIMESTAMP``
     - TIMESTAMP
     - Last update

oe_payments_transaction
-----------------------

.. list-table::
   :header-rows: 1
   :widths: 25 20 55

   * - Column
     - Type
     - Description
   * - ``OXID``
     - VARCHAR(32)
     - Transaction ID
   * - ``OXCONTRACTID``
     - VARCHAR(32)
     - Contract ID (FK)
   * - ``OXPROVIDERID``
     - VARCHAR(255)
     - Provider transaction ID
   * - ``OXTYPE``
     - VARCHAR(32)
     - Transaction type
   * - ``OXAMOUNT``
     - DOUBLE
     - Amount
   * - ``OXSTATUS``
     - VARCHAR(32)
     - Transaction status
