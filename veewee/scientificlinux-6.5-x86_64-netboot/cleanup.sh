# Cleanup script.

# Remove unused packages.
yum -y erase gtk2 libX11 hicolor-icon-theme freetype bitstream-vera-fonts

# Clean yum cache.
yum -y clean all

# Remove anaconda kickstart configuration.
rm -f /root/anaconda-ks.cfg
rm -f /root/install.log*

# Remove temporary files.
rm -rf /tmp/*

# Remove traces of mac address from network configuration.
sed -i /HWADDR/d /etc/sysconfig/network-scripts/ifcfg-eth0

