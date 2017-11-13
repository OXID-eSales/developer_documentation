Troubleshooting
===============

I am asked for a github token
---------------------------------------------------

By default github has API access limits set for anonymous access. In order to overcome these limits one has to create a github token, which could be done as described in: https://help.github.com/articles/creating-an-access-token-for-command-line-use/


I get a Composer\\Downloader\\TransportException
------------------------------------------------

During the installation of OXID eShop Professional or Enterprise Edition you get the following error:

::

  [Composer\Downloader\TransportException]
  Invalid credentials for 'https://enterprise-edition.packages.oxid-esales.com/packages.json', aborting.


You may have stored some outdated or wrong credentials. Please review <your home directory>/.composer/auth.json and
delete the section, which begins with "professional-edition.packages.oxid-esales.com" resp. "enterprise-edition.packages.oxid-esales.com"


I am asked "Do you want to remove the existing VCS (.git, .svn..) history? [Y,n]"
---------------------------------------------------------------------------------

In general you can say "Yes". It is not normally important to keep VCS history locally. You can always look it up on github.


There was an error during the execution of the unified namespace generator
--------------------------------------------------------------------------

If the generation of the `unified namespace classes` fails, OXID eShop will not run properly.
In this case you should look :doc:`here<../../oxid_components/unified_namespace_generator>` for possible fixes.
