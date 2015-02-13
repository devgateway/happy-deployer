# = Class: happydev::fairy_dust::vanilla_cream
#

class happydev::fairy_dust::vanilla_cream (
  $vhosts = hiera('vhosts', []),
) {
  if $::kernel == 'Linux' {
    Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

    $project_docroot = $vhosts['0']['docroot']
    file { '/etc/profile.d/custom-jekyll.sh':
      ensure  => file,
      content => template('happydev/custom-jekyll.sh.erb'),
    }
  }
}
