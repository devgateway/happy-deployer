# Install Puppet.

# Import the Puppet Labs public key.
wget -O - https://downloads.puppetlabs.com/puppetlabs-gpg-signing-key.pub | gpg --import

# Install the repository.
rpm -Uvh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm

# Wee need to lock puppet dependencies to a particular version,
# because of some repository issues.
yum -y install yum-plugin-versionlock

# Install Puppet and dependencies and lock their version.
yum -y install puppet-3.4.3 facter-1.7.5 hiera-1.3.2
yum versionlock puppet facter hiera

