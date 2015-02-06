# = Class: jekyll
#

class happydev::jekyll (
  $vhosts = hiera('vhosts', []),
) {

  # Install the nginx web server.
  class { 'nginx': }

  # Install Ruby Version Manager
  class { 'rvm': }

  # Allow the vagrant user to install gems.
  rvm::system_user { 'vagrant':
    create  => false,
    require => Class['rvm'];
  }

  # Install ruby.
  rvm_system_ruby { 'ruby-2.2':
    ensure      => 'present',
    default_use => true,
  }

  # Create a gemset for the project.
  rvm_gemset { 'ruby-2.2@dgorg':
    ensure  => 'present',
    require => Rvm_system_ruby['ruby-2.2'];
  }

  # Install bundler easily install dependencies.
  rvm_gem { 'bundler':
    name         => 'bundler',
    ruby_version => 'ruby-2.2@dgorg',
    ensure       => 'latest',
    require      => Rvm_gemset['ruby-2.2@dgorg'];
  }

  # Install gem dependencies.
  package { 'libicu-devel':
    ensure   => latest,
    provider => 'yum',
  }

  # Install gem dependencies.
  package { 'cmake':
    ensure   => latest,
    provider => 'yum',
  }

  # Required to run 'jekeyll serve'.
  package { 'nodejs':
    ensure   => latest,
    provider => 'yum',
  }

  # Setup projects.
  each($vhosts) |$vhostinfo| {
    exec { "gem update in ${vhostinfo['domain']}":
      command   => '/usr/local/rvm/bin/rvm ruby-2.2@dgorg do gem update',
      user      => 'vagrant',
      cwd       => $vhostinfo['docroot'],
      logoutput => true,
      require   => [
        Package['libicu-devel'],
        Package['cmake'],
        Package['nodejs'],
        Rvm_gem['bundler'],
      ],
    } ->
    exec { "bundle install in ${vhostinfo['domain']}":
      command   => '/usr/local/rvm/bin/rvm ruby-2.2@dgorg do bundle install',
      user      => 'vagrant',
      cwd       => $vhostinfo['docroot'],
      logoutput => true,
    }

    # Setup a virtual host for the project.
    nginx::resource::vhost { $vhostinfo['domain']:
      ensure               => present,
      listen_port          => 80,
      use_default_location => false,
      server_name          => [ $vhostinfo['domain'] ],
      www_root             => "${vhostinfo['docroot']}/_site",
      index_files          => [ 'index.html' ],
      access_log           => "/var/log/nginx/${vhostinfo['domain']}__access.log",
      error_log            => "/var/log/nginx/${vhostinfo['domain']}__error.log",
      vhost_cfg_append     => {
        'expires'       => '2h',
        'server_tokens' => 'off',
      },
    }
  }

  # Setup iptables to allow access to the HTTP server.
  firewall { '100 allow nginx and jekyll access':
    port    => [80, 4000],
    proto   => tcp,
    action  => accept,
  }
}
