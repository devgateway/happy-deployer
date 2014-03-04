# = Class: happydev::fairy_dust::orange_blossom
#
# == Requires:
#
# * happydev::rhel
#

class happydev::fairy_dust::orange_blossom {

  if $::kernel == 'Linux' {
    Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

    # Install bash-completion if missing.
    package { 'bash-completion':
      ensure => installed,
    }

    # Install Vi IMproved editor.
    package { 'vim':
      ensure => installed,
      name => $::operatingsystem ? {
        Scientific => "vim-enhanced",
        Ubuntu => "vim",
      }
    }

    # Updat the 'message of the day'.
    # @see http://linux.die.net/man/5/motd
    file { '/etc/motd':
      content => template('happydev/etc-motd.erb'),
      ensure  => file,
    }

    file { '/etc/profile.d/custom.sh':
      content => template('happydev/bash-custom.sh.erb'),
      ensure  => file,
      group => 'vagrant',
      owner => 'vagrant',
    }
  }
}
