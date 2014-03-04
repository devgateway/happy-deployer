# = Class: happydev::mysql
#
# == Requires:
#
# * puppetlabs/mysql (2.x)
#   @see http://forge.puppetlabs.com/puppetlabs/mysql
#

class happydev::mysql (
  $root_password = hiera('mysql_root_password', 'this_is_a_random_password'),
  $databases = hiera('mysql_databases', []),
) {

  # Configure MySQL.
  class { '::mysql::server':
    root_password => $root_password,

    override_options => {
      'mysqld' => {
        'max_allowed_packet' => '256M',
      },
      'mysqldump' => {
        'max_allowed_packet' => '256M',
      },
    },
  }

  # Create the databases.
  each($databases) |$dbinfo| {
    mysql::db { $dbinfo['name']:
      user => $dbinfo['user'],
      password => $dbinfo['pass'],
      host => 'localhost',
      grant => ['ALL'],
    }
  }
}
