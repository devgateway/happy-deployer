# = Class: happydev::fairy_dust::water_lily
#

class happydev::fairy_dust::water_lily {
  if $::kernel == 'Linux' {
    Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

    # Create drush alias.
    file { '/etc/profile.d/custom-drush.sh':
      content => "alias d=`which drush`\nalias dr=`which drush`\n",
      ensure  => file,
    }
  }
}
