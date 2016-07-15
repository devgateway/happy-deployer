# Install VirtualBox guest additions requirements.
# @see https://wiki.centos.org/HowTos/Virtualization/VirtualBox/CentOSguest
yum --assumeyes install kernel-devel dkms
yum --assumeyes groupinstall "Development Tools"

# Install VirtualBox guest additions.
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
mount --options loop,ro /home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm --force /home/vagrant/VBoxGuestAdditions_*.iso
