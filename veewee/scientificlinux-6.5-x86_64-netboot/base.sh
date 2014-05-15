# Base install

# Allow sudo to run not only when the user is logged in to a real tty but also
# via other means such as cron(8) or cgi-bin scripts.
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# Do not keep old kernel versions.
sed -i "s/^installonly_limit=3/installonly_limit=0/" /etc/yum.conf

# Bootstrap the EPEL repository.
cat > /etc/yum.repos.d/epel-bootstrap.repo << EOM
[epel-bootstrap]
name=EPEL Bootstrap
mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=epel-\$releasever&arch=\$basearch
enabled=1
gpgcheck=0
failovermethod=priority
EOM

# Add the proper EPEL repository.
yum -y install epel-release

# Make sure the created box is up-to-date.
yum -y update

# Install required packages.
yum -y install gcc make gcc-c++ kernel-devel-`uname -r` zlib-devel openssl-devel readline-devel sqlite-devel perl wget dkms
