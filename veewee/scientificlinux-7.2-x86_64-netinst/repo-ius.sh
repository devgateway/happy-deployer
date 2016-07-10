# Install "Inline with Upstream Stable" Repository.
# @see: https://ius.io/

# Download and install the repository.
rpm --quiet -Uh https://centos7.iuscommunity.org/ius-release.rpm

# Import the public key.
gpg --import /etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY
