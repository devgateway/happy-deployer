#!/bin/bash

echo 'Configure Hiera...'

# Hiera configuration for puppet. Goes as content into /etc/puppet/hiera.yaml
DATA_FOLDER='/var/lib/hiera'

# Setup Hiera.
# @see http://docs.puppetlabs.com/hiera/1/index.html

# Hiera uses an ordered hierarchy to look up data.
# @see http://docs.puppetlabs.com/hiera/1/hierarchy.html
HIERA_FILE='/etc/puppet/hiera.yaml'
cat << EOF > $HIERA_FILE
---
:backends:
  - yaml

:yaml:
  :datadir: $DATA_FOLDER

:hierarchy:
  - %{hostname}
  - %{environment}
  - common

EOF

# Create link to common hiera settings.
# @TODO: Provide environment specific settings (see :hierarchy: in /etc/puppet/hiera.yaml).
if !(test -L "${DATA_FOLDER}/common.yaml"); then
  echo "Creating symbolic link:"
  mkdir -p $DATA_FOLDER
  ln --verbose --symbolic /vagrant/Vagrantsettings.yaml $DATA_FOLDER/common.yaml
fi
