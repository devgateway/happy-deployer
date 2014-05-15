# Install Puppet

cat > /etc/yum.repos.d/puppetlabs.repo << EOM
[puppetlabs-dependencies]
name=puppetlabdsdependencies
baseurl=http://yum.puppetlabs.com/el/6/dependencies/\$basearch
enabled=1
gpgcheck=0

[puppetlabs]
name=puppetlabs
baseurl=http://yum.puppetlabs.com/el/6/products/\$basearch
enabled=1
gpgcheck=0
EOM

# Install puppet and facter.
yum -y install puppet-3.4.3 facter-1.7.5


cat >> /tmp/puppetlabs.repo << EOM
# Prevent puppet and facter updates.
exclude=puppet facter
EOM
