happy-deployer CHANGELOG
=====================

0.1.8
-----
* Change list of installed PHP modules.
* Setup xdebug for remote debugging.
* Allow PostgreSQL remote debugging.
* Add an entry for each PostgreSQL database in the password file of the vagrant user.
* Set the PostgreSQL [bytea_output](http://www.postgresql.org/docs/9.2/static/runtime-config-client.html) to escape.

0.1.7
-----
* Use the host's resolver mechanisms to handle DNS requests. Improves apparent Internet speed.
* Improve PHP manifest file.

0.1.6
-----
* Finetune version numbers for dependencies.

0.1.5
-----
* Add MongoDB support.
* Reduce complexity of the example Vagrantfile and Vagrantsettings.yaml.
* Support multiple projects in the same VM.
* Add custom [veewee](https://github.com/jedi4ever/veewee) template for Scientific Linux 64-bit v5.5.

0.1.4
-----
* Cleanup Vagrantfile and Vagrantsettings.yaml.
* Fix PHP settings update functionality.

0.1.3
-----
* Update bash aliases.

0.1.2
-----
* Fix apache-vboxfs issue: Files get corrupted after modifying on host.

0.1.1
-----
* Only run PEAR commands when Drush is missing.
* Update all templates to use data from Hiera.

0.1.0
-----
* Initial release of happy-deployer.
