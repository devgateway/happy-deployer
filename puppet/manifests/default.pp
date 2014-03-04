
# Copy a node to awesome-project.pp and make sure Vagrantsettings.yml points to the new file.

node default {
  info('You just built yourself an empty VM!')
}

node /^awesome-.+$/  {
  info('You just build yourself an awesome VM!')
}

node 'db_server' {
  class { '::happydev::pgsql': }
}

node 'orange_blossom' {
  # Do some magic!
  class { '::happydev::rhel': } ->
  class { '::happydev::fairy_dust::orange_blossom': } ->
  class { '::happydev::mysql': } ->
  class { '::happydev::pgsql': } ->
  class { '::happydev::apache_php': }
}

node 'vanilla_cream' {
  # Do some magic!
  class { '::happydev::rhel': } ->
  class { '::happydev::fairy_dust::vanilla_cream': } ->
  class { '::happydev::pgsql': } ->
  class { '::happydev::apache_php': }
}
