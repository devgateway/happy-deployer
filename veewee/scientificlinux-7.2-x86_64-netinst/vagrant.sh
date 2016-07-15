# Add box build time.
date > /etc/vagrant_box_build_time

# Installing vagrant keys.
# NOTE: The vagrant user is created during kickstart.
mkdir --parents --mode=700 /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown --recursive vagrant:vagrant /home/vagrant/.ssh

# Customize the message of the day.
echo 'Welcome to your Vagrant-built virtual machine.' > /etc/motd
