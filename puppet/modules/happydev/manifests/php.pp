# = Class: happydev::apache_php
#
# == Requires:
# * http://forge.puppetlabs.com/example42/php
# * http://forge.puppetlabs.com/example42/puppi
#
# == TODO:
#

class happydev::php {
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

  # Install and setup PHP v5
  class { '::php':
    # version => '5.3',
  }

  # Setup PHP with Apache HTTPD if needed.
  if (defined(Class['happydev::apache'])) {
    class { '::apache::mod::php':
      require => [
        Package['httpd'],
        Package['php'],
      ],
      notify => Service['httpd'],
    }

    # Always proccess after apache and 'request' a httpd restart when finished!
    Class['php'] -> Class['apache']
    Class['php'] ~> Class['apache']
  }

  # Setup PHP with Nginx if needed.
  if (defined(Class['happydev::nginx'])) {
    # @TODO
  }

  # Install required PHP modules.
  $php_modules = [
    # 'curl',
    'gd',
    # 'geoip',
    'mbstring',
    # 'mcrypt',
    'mysql',
    'pdo',
    'pecl-mongo',
    'pgsql',
    #'php-gettext',
    'xml',
  ]
  php::module { $php_modules: }

  php::ini { 'default':
    value => [
      'max_execution_time = 60',
      'memory_limit = 512M',
      'post_max_size = 128M',
      'upload_max_filesize = 128M',
    ],
    target => 'custom.ini'
  }

  php::ini { 'devel':
    value => [
      'date.timezone = America/Chicago',
      'error_reporting = E_ALL | E_STRICT',
      'display_errors = On',
      'display_startup_errors = On',
    ],
    target => 'custom-devel.ini'
  }

  # Install Xdebug.
  # class { 'xdebug': }

  # Install Composer - A dependency manager for PHP
  $composer_home = '/opt/composer'
  Exec { environment => "COMPOSER_HOME=${composer_home}" }
  exec { 'install-composer':
    command => 'curl -sS https://getcomposer.org/installer | php',
    cwd => $composer_home,
    onlyif => 'test ! -f /usr/bin/composer', # checks for valid symbolic link.
    require => [
      Package['php'],
      File['/opt/composer'],
    ],
  } ->
  file { '/usr/bin/composer':
    ensure  => link,
    target  => "${composer_home}/composer.phar",
  }

  # Helper function.
  file { '/opt/composer':
    ensure  => directory,
  }

  # Install Drush.
  exec { 'install-drush':
    command => 'composer global require drush/drush:6.*',
    require => Exec['install-composer'],
    notify => Exec['install-drush-dependencies'],
    onlyif => 'test ! -f /usr/bin/drush', # checks for valid symbolic link.
  }

  exec { 'install-drush-dependencies':
    command => 'drush',
    refreshonly => true,
  }

  # Create a simbolic link and aliases for drush.
  file { '/usr/bin/drush':
    ensure  => link,
    target  => "${composer_home}/vendor/drush/drush/drush", # drush is the vedor, the application name and the executable.
    require => Exec['install-drush'],
  } ->
  file { '/etc/profile.d/custom-drush.sh':
    ensure  => file,
    content => "alias d=/usr/bin/drush\nalias dr=/usr/bin/drush\n",
  }

  # Create a simbolic link to enable drush completion.
  file { '/etc/bash_completion.d/drush.complete.sh':
    ensure  => link,
    target  => "${composer_home}/vendor/drush/drush/drush.complete.sh",
    require => Exec['install-drush'],
  }
}
