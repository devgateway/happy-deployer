
# Copy a node to awesome-project.pp and make sure Vagrantsettings.yml uses the new manifest file.

node default {
  info('You just built yourself an empty VM!')
}

node /^awesome-.+$/  {
  info('You just build yourself an awesome VM!')
}

node 'db_server' {
  include ::happydev::rhel
  include ::happydev::fairy_dust::orange_blossom
  include ::happydev::pgsql
}

node 'lamp' {
  # Export facts to /tmp/facts.yaml.
  # include ::happydev::fairy_dust::debug_helper

  include ::happydev::rhel
  include ::happydev::mysql
  include ::happydev::apache
  include ::happydev::php
}
