# Remove the EPEL bootstrap repo.
rm -rf /etc/yum.repos.d/epel-bootstrap.repo

yum -y erase gtk2 libX11 hicolor-icon-theme avahi freetype bitstream-vera-fonts
yum -y clean all

rm -rf VBoxGuestAdditions_*.iso
