# = Class: happydev::apache_php
#
# == Requires:
# * http://forge.puppetlabs.com/puppetlabs/apache
# * http://forge.puppetlabs.com/puppetlabs/firewall
#
# == TODO:
# * Run apache as a differend user!
# * Make this work on debian systems.
# * Test if web server is accessible from all IPs of the server!
#

class happydev::apache (
  $vhosts = hiera('vhosts', []),
) {

  # Install and configure Apache HTTP
  class { '::apache':
    # Run apache as vagrant.
    user           => 'vagrant',
    group          => 'vagrant',

    # Make sure the service is enabled when the machine is booted.
    service_enable => true,

    # http://httpd.apache.org/docs/2.2/mod/core.html#enablesendfile
    # https://forums.virtualbox.org/viewtopic.php?f=7&t=56066
    sendfile       => 'Off',

    # Do not create a default vhost.
    default_vhost  => false,

    # Move the location of vhosts.
    vhost_dir      => '/etc/httpd/vhosts.d',
  }

  # Setup virtual hosts.
  each($vhosts) |$vhostinfo| {
    apache::vhost { $vhostinfo['domain']:
      port          => '80',
      serveraliases => $vhostinfo['aliases'],

      docroot       => $vhostinfo['docroot'],
      docroot_owner => 'vagrant',
      docroot_group => 'vagrant',

      override      => 'all',
      # Make _rewrite.erb print "RewriteEngine On", also enables mod_rewrite
      rewrites      => [{}],

      require       => File[$vhostinfo['docroot']],
    }

    # Change the owner and group of the document root.
    file { $vhostinfo['docroot']:
      ensure => directory,
      group  => 'vagrant',
      owner  => 'vagrant',
    }
  }

  # Setup iptables to allow access to the HTTP server.
  firewall { '100 allow HTTP and HTTPS access':
    port    => [80, 443],
    proto   => tcp,
    action  => accept,
    require => [
      Package['httpd'],
    ],
  }
}
