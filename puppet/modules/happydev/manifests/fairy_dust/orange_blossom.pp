# = Class: happydev::fairy_dust::orange_blossom
#

class happydev::fairy_dust::orange_blossom (
  $project_environment = hiera('vm_environment', 'local'),
  $project_hostname = hiera('vm_hostname', 'the-project'),
  $vhosts = hiera('vhosts', []),
) {
  if $::kernel == 'Linux' {
    Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

    # Install bash-completion if missing.
    package { 'bash-completion':
      ensure => installed,
    }

    # Install Vi IMproved editor.
    package { 'vim':
      ensure => installed,
      name   => 'vim-enhanced',
    }

    # Updat the 'Message Of The Day'.
    # @see http://linux.die.net/man/5/motd
    file { '/etc/motd':
      ensure  => file,
      content => template('happydev/etc-motd.erb'),
    }

    $project_docroot = $vhosts['0']['docroot']
    file { '/etc/profile.d/custom.sh':
      ensure  => file,
      content => template('happydev/bash-custom.sh.erb'),
    }
  }
}
