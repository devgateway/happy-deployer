# = Class: happydev::fairy_dust::vanilla_cream
#

class happydev::fairy_dust::vanilla_cream (
  $epel_repo = false,
) {

  if $::kernel == 'Linux' {
    Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

    # Install Midnight Commander.
    package { 'mc':
      ensure => present,
    }

    # Install Joe's Own Editor.
    package { 'joe':
      ensure => present,
    }

    # Updat the 'message of the day'.
    # @see http://linux.die.net/man/5/motd
    $project_name = hiera('hostname', 'localhost')
    $project_environment = hiera('environment', 'LOCAL')
    file { '/etc/motd':
      content => template('happydev/etc-motd.erb'),
      ensure  => file,
    }
  }
}
