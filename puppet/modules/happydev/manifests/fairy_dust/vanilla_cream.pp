# = Class: happydev::fairy_dust::vanilla_cream
#

class happydev::fairy_dust::vanilla_cream {
  if $::kernel == 'Linux' {
    Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

    # Install Midnight Commander.
    package { 'mc':
      ensure => present,
    }

    # Install "Joe's Own Editor" editor.
    package { 'joe':
      ensure => present,
    }
  }
}
