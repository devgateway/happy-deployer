# = Class: happydev::mongodb
#
# == Requires:
#
# * 'puppetlabs/mongodb', '0.7.0'
#   @see http://forge.puppetlabs.com/puppetlabs/mongodb
# * 'puppetlabs/stdlib', '3.2.1'
#   @see http://forge.puppetlabs.com/puppetlabs/stdlib
#

class happydev::mongodb (
  $root_password = hiera('pgsql_root_password', 'this_is_a_random_password'),
  $databases = hiera('mongo_databases', []),
) {

  # Install and configure MongoDB.
  # class { '::mongodb::globals':
  #   manage_package_repo => true,
  # } ->
  class { '::mongodb::server':
    auth => true,
  } ->
  class { '::mongodb::client':
  }

  # Create the databases.
  each($databases) |$dbinfo| {
    mongodb::db { $dbinfo['name']:
      user => $dbinfo['user'],
      password_hash => mongodb_password($dbinfo['user'], $dbinfo['pass']),
    }
  }
}
