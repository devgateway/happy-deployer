happy-deployer CHANGELOG
=====================

0.2.01
-----
* Removed CURL.

0.2.0
-----
* Reverted puppet module metadata format, Puppet v3.6.0 is not aviablable in the RHEL repo.

0.1.9
-----
* Updated metadata for [Puppet Forge](https://forge.puppetlabs.com)

0.1.8
-----
* Changed list of installed PHP modules.
* Setup xdebug for remote debugging.
* Allow PostgreSQL remote debugging.
* Added an entry for each PostgreSQL database in the password file of the vagrant user.
* Set the PostgreSQL [bytea_output](http://www.postgresql.org/docs/9.2/static/runtime-config-client.html) to escape.

0.1.7
-----
* Set the host's resolver mechanisms to handle DNS requests. Improves apparent Internet speed.
* Improved PHP manifest file.

0.1.6
-----
* Finetuned version numbers for dependencies.

0.1.5
-----
* Added MongoDB support.
* Reduceed complexity of the example Vagrantfile and Vagrantsettings.yaml.
* Added support for multiple projects in the same VM.
* Added custom [veewee](https://github.com/jedi4ever/veewee) template for Scientific Linux 64-bit v5.5.

0.1.4
-----
* Cleaned up Vagrantfile and Vagrantsettings.yaml.
* Fix PHP settings update functionality.

0.1.3
-----
* Updated bash aliases.

0.1.2
-----
* Fixed apache-vboxfs issue: Files get corrupted after modifying on host.

0.1.1
-----
* Updated Drush setup instructions.
* Updated all templates to use data from Hiera.

0.1.0
-----
* Initial release of happy-deployer.
