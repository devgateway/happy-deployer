happy-deployer
==============

Requirements
------------

Latest [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
Latest [Vagrant](http://www.vagrantup.com/downloads.html)


Setup Instructions
------------------

1. Install VirtualBox
2. Install Vagrant
3. Drop the vagrant files directly into your project folder.
4. Create your virtual development environment (you might need to wait for a while):
```
vagrant up --provision
```
5. Happy coding!


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
