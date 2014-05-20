happy-deployer
==============

Requirements
------------

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](http://www.vagrantup.com/downloads.html)
* [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest)
* [vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) (tested on linux and Mac OS)


Setup Instructions
------------------

* Install VirtualBox
* Install Vagrant
* Install the Vagrant plugins:
```
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-hostsupdater
```
* Drop the vagrant files directly into your project folder.
* Create your virtual development environment (you might need to wait for a while):
```
vagrant up --provision
```
* Happy coding!


How to
------
* Shut down your VM:
```
vagrant halt
```

* Delete your VM (yes you will LOOSE all your data that exists only in the VM):
```
vagrant destroy
```

* Update (after new configuration files were provided) or reset environment settings:
```
vagrant provision
```
