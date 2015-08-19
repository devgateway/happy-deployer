# happy-deployer


## Requirements

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](http://www.vagrantup.com/downloads.html)
* [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) and a C compiler
* [vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) (tested on linux and Mac OS)
* (optional) [vagrant-bash-completion](https://github.com/kura/vagrant-bash-completion)


## Setup Instructions

* Install VirtualBox

* Install Vagrant, and optionally the bash completion script.

* Make sure you have a C compiler installed, required to compile [Ruby-FFI](https://github.com/ffi/ffi)
  for the 'vagrant-vbguest' plugin.
  ```
  gcc --version
  ```

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


## How to

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

## More Info

* [Puppet Style Guide](https://docs.puppetlabs.com/guides/style_guide.html)
* [Puppet Function Reference](https://docs.puppetlabs.com/references/latest/function.html)
* [Puppet Type Reference](https://docs.puppetlabs.com/references/latest/type.html)
