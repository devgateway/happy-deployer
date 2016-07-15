# Install VirtualBox guest additions requirements.
# @see https://wiki.centos.org/HowTos/Virtualization/VirtualBox/CentOSguest
yum -y install kernel-devel dkms
yum groupinstall "Development Tools"

# Install VirtualBox guest additions.
VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
mount -o loop,ro /home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm -f /home/vagrant/VBoxGuestAdditions_*.iso
