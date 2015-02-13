# Install VirtualBox Guest Additions.

# Get the VirtualBox version.
VBOX_VERSION=$(cat /home/veewee/.vbox_version)

# Install VirtualBox Guest Additions.
mount -o loop /home/veewee/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt

# Remove the GA ISO file.
rm -rf /home/veewee/VBoxGuestAdditions_*.iso

