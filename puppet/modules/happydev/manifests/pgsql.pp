# = Class: happydev::pgsql
#
# == Requires:
# * http://forge.puppetlabs.com/puppetlabs/postgresql
# * http://forge.puppetlabs.com/puppetlabs/concat
#

class happydev::pgsql (
  $root_password = hiera('pgsql_root_password', 'this_is_a_random_password'),
  $databases = hiera('pgsql_databases', []),
) {

  # Install and configure PostgreSQL.
  class { 'postgresql::globals':
    manage_package_repo => true,
    version => '9.2',
    # pg_hba_conf_defaults => false,
  } ->
  class { '::postgresql::server':
    postgres_password => $root_password,
  }

  class { '::postgresql::server::contrib': }

  # Create the databases.
  each($databases) |$dbinfo| {
    postgresql::server::db { $dbinfo['name']:
      user => $dbinfo['user'],
      password => postgresql_password($dbinfo['user'], $dbinfo['pass']),
    }
  }
}
