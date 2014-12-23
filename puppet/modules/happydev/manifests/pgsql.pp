# = Class: happydev::pgsql
#
# == Requires:
# * http://forge.puppetlabs.com/puppetlabs/postgresql
# * http://forge.puppetlabs.com/puppetlabs/concat
#

class happydev::pgsql (
  $root_password = hiera('pgsql_root_password', 'this_is_a_random_password'),
  $databases = hiera('pgsql_databases', []),
  $allow_remote_access = hiera('pgsql_allow_remote_access', false),
) {

  # Setup iptables to allow remote access to the PostgreSQL server.
  if ($allow_remote_access) {
    $listen_addresses = ['localhost', $ipaddress_eth1]

    firewall { '125 allow PostgreSQL access':
      port    => [5432],
      proto   => tcp,
      action  => accept,
      require => [
        Class['::postgresql::server'],
      ],
    }
  } else {
    $listen_addresses = ['localhost']
  }

  # Install and configure PostgreSQL.
  class { 'postgresql::globals':
    manage_package_repo => true,
    version             => '9.2',
    # pg_hba_conf_defaults => false,
  } ->
  class { '::postgresql::server':
    postgres_password => $root_password,
    listen_addresses  => join($listen_addresses, ','),
  } ->
  # Set the output format for 'serialized strings'.
  # @see http://www.postgresql.org/docs/9.2/static/runtime-config-client.html
  # ALTER DATABASE dbname SET bytea_output = 'escape';
  postgresql::server::config_entry { 'bytea_output':
    value => 'escape',
  }

  class { '::postgresql::server::contrib': }

  # Create the databases.
  each($databases) |$dbinfo| {
    # Prepare variables for the Password File.
    # @see http://www.postgresql.org/docs/9.2/static/libpq-pgpass.html
    if (empty($dbinfo['host'])) {
      $host = 'localhost'
    }
    else {
      $host = $dbinfo['host']
    }
    if (empty($dbinfo['port'])) {
      $port = '5432'
    }
    else {
      $port = $dbinfo['port']
    }
    $pgpass_info = [
      $host,
      $port,
      $dbinfo['name'],
      $dbinfo['user'],
      $dbinfo['pass'],
    ]

    postgresql::server::db { $dbinfo['name']:
      user => $dbinfo['user'],
      password => postgresql_password($dbinfo['user'], $dbinfo['pass']),
    } ->
    # Create password file.
    file { '/home/vagrant/.pgpass':
      ensure  => file,
      content => join($pgpass_info, ':'),
      mode    => '0600',
      group   => 'vagrant',
      owner   => 'vagrant',
    }

    if ($allow_remote_access) {
      # # Rule Name: allow remote access to dbname
      # # Description: Opens up postgresql for remote access
      # # Order: 150
      # host  dbname  username  10.10.10.0/24  md5
      postgresql::server::pg_hba_rule { "allow remote access to ${dbinfo['name']}":
        description => 'allows remote access in the 10.10.10.0/24 subnet',
        type        => 'host',
        database    => $dbinfo['name'],
        user        => $dbinfo['user'],
        address     => '10.10.10.0/24',
        auth_method => 'md5',
      }
    }
  }
}
