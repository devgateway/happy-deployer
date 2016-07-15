happy-deployer CHANGELOG
========================

0.3.x
-----
* Add basic PostgreSQL Ansible role.
* Ansible common: Install net-tools, vim, wget.
* Veewee: Update VirtualBox Guest Additions install script. Install "Development Tools" group.

0.3.0
-----
* Updated to Scientific Linux 7
* Remove Puppet provisioning in favor of Ansible.
* PostgreSQL, MongoDB and Jekyll provisioning has not been implemented in Ansible.
* Added Inline with Upstream Stable (IUS) repository.
* Added logrotate configuration for HTTPD.
* Configured Umask for properly configuring files managed by the web server and developers.
* Updated Drush to v8.
* Updated PHP to v5.6.
* Installed Composer PHP package manager.
* Added Solr and Memcached playbooks.
* Controlling firewall and listening ports for Apache HTTPD, MariaDB (MySQL), Memcached and Solr.
* Added the possibility to create users.
* Installed yum-cron in order to automatically install updates.
* And more...

0.2.11
------
* Revert Drush to version 6.6.0.

0.2.10
------
* Fixed composer install.

0.2.9
-----
* Updated puppet module dependencies.
* Locked puppet module versions.
* Fixed Drush7 installation on PHP 5.3.3.

0.2.7 - 0.2.8
-----
* Updated puppet module dependencies.

0.2.6
-----
* Updated ruby gemset for jekyll vhost template.

0.2.5
-----
* Updated jekyll manifest to allow for different nginx vhosts.

0.2.4
-----
* Updated SL6 Veewee template.
* Updated and fixed manifests.
* Add new puppet recipe for installing jekyll.

0.2.2 - 0.2.3
-----
* Fixed PostgreSQL user password file.

0.2.1
-----
* Removed CURL.

0.2.0
-----
* Reverted puppet module metadata format, Puppet v3.6.0 is not available in the RHEL repo.

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
* Fine-tuned version numbers for dependencies.

0.1.5
-----
* Added MongoDB support.
* Reduced complexity of the example Vagrantfile and Vagrantsettings.yaml.
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
