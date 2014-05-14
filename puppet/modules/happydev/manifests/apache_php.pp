# = Class: happydev::apache_php
#
# == Requires:
#
# * 'puppetlabs/apache', '1.x'
#   @see http://forge.puppetlabs.com/puppetlabs/apache
# * 'puppetlabs/firewall', '1.x'
#   @see http://forge.puppetlabs.com/puppetlabs/firewall
# * 'example42/php', '2.x'
#   @see http://forge.puppetlabs.com/example42/php
# * 'example42/puppi', '>= 2.0.0'
#   @see http://forge.puppetlabs.com/example42/puppi
# * 'rafaelfc/pear', '1.x'
#   @see http://forge.puppetlabs.com/rafaelfc/pear
#
# == TODO:
#
# * Run apache as a differend user!
# * Do not try to install pecl plugins a seccond time
# * Test if web server is accessible from all IPs of the server!
#

class happydev::apache_php (
  $docroot = hiera('docroot', '/var/www'),
  $domain = hiera('domain', 'localhost.localdomain'),
) {

  # Install and configure Apache HTTP
  class { '::apache':
    # Run apache as vagrant.
    user => 'vagrant',
    group => 'vagrant',

    # http://httpd.apache.org/docs/2.2/mod/core.html#enablesendfile
    # https://forums.virtualbox.org/viewtopic.php?f=7&t=56066
    sendfile => 'Off',
  }

  # Make sure mod_php and all dependencies are enabled after PHP is installed.
  class { 'apache::mod::php':
    require => Package['php']
  }

  # Setup project virtual host.
  apache::vhost { $domain:
    port => '80',
    docroot => $docroot,
    override => 'all',
    docroot_owner => 'vagrant',
    docroot_group => 'vagrant',
    # Make _rewrite.erb print "RewriteEngine On", also enables mod_rewrite
    rewrites => [{}],

    require => File[$docroot],
  }

  # Setup iptables to allow access to the HTTP server.
  firewall { '100 allow HTTP and HTTPS access':
    port => [80, 443],
    proto => tcp,
    action => accept,
  }

  # # Change the owner and group of the document root.
  file { $docroot:
    ensure => directory,
    group => 'vagrant',
    owner => 'vagrant',
    # recurse => true,
  }

  # @TODO: Test if web server is accessible from all IPs of the server!
  # file { "${docroot}/test.html":
  #   ensure  => file,
  #   content => 'The webserver works just fine!!!',
  #   group => 'vagrant',
  #   owner => 'vagrant',
  # }

  # Install and setup PHP v5
  class { 'php':
    # version => '5.3',
    notify => Service['httpd'],
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
  each($php_modules) |$module_name| {
    php::module { $module_name: }
  }

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

  service { 'apache':
    restart => true,
  }

  # class { 'xdebug': }

  # Install the PHP Extension and Application Repository
  # We don't like the pear class from example42/php so we use rafaelfc/pear
  # class { 'php::pear':
  #   require => Class['php'],
  # }
  class { 'pear':
    require => Class['php'],
  }

  if ($drush_status == 'missing') {
    # Update PEAR channel (avoid warnings "channel X has updated its protocols")
    # Not required, this is solved by rafaelfc/pear.
    # exec { "update pear.php.net channel":
    #   command => "pear channel-update pear.php.net",
    #   logoutput => true,
    # }
    pear::package { 'PEAR':
      require => Class['pear'] # make sure pear is installed before.
    }

    # Install the upload progress.
    pear::package { 'uploadprogress':
      repository => 'pecl.php.net',
      require => Pear::Package['PEAR'] # make sure pear is upgraded before.
    }

    # Setup Drush.
    pear::package { 'Console_Table':
      require => Pear::Package['PEAR'] # make sure pear is upgraded before.
    } ->
    pear::package { 'drush':
      repository => 'pear.drush.org',
    }
  }

  # file { "${docroot}/test.php":
  #   ensure  => file,
  #   content => '<?php phpinfo();',
  #   group => 'vagrant',
  #   owner => 'vagrant',
  # }
}
