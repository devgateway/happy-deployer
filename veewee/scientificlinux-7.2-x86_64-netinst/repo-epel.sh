# Install EPEL Repository.
# @see: https://fedoraproject.org/wiki/EPEL

# Download and install the repository.
rpm --quiet -Uh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# Import the public key.
gpg --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
