# Base install

# Allow sudo to run not only when the user is logged in to a real tty but also
# via other means such as cron(8) or cgi-bin scripts.
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# Do not keep old kernel versions. (RISKY!)
sed -i "s/^installonly_limit=3/installonly_limit=0/" /etc/yum.conf

# Remove all wireles drivers.
rpm -qa | grep ^iwl.*-firmware | xargs -i{} yum -y erase {}

# Make sure the created box is up-to-date.
yum -y update

# Install required packages.
yum -y install kernel-devel kernel-headers gcc make gcc-c++ zlib-devel openssl-devel readline-devel perl wget

# Make SSH access into the VM faster by not waiting on DNS when internet is down.
# sed -i "s/^.*UseDNS.*/UseDNS no/" /etc/ssh/sshd_config
echo "UseDNS no" >> /etc/ssh/sshd_config

