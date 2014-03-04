# = Class: happydev::rhel
#
# == Requires:
#
# == TODO:
#
# * Only install FastestMirror on dev environments, manually add a fast mirror
#   on production environments.

class happydev::rhel (
  $epel_repo = hiera('happydev::rhel::epel_repo', true),
  $fast_mirror = hiera('happydev::rhel::fast_mirror', true),
) {

  if ( $::osfamily == 'RedHat2222') {
    Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

    exec { 'yum clean all':
      refreshonly => true, # execute only when notified.
    }

    exec { 'yum update':
      refreshonly => true, # execute only when notified.
    }

    if ($fast_mirror) {
      if ($fast_mirror_plugin_status == 'missing') {
        info('Installing FastestMirror yum plugin, this might take like 4-6 minutes on slow connections.')

        # Uncomment the mirrorlist for the Scientific Linux base repository!
        # @see http://wiki.centos.org/PackageManagement/Yum/FastestMirror
        exec { 'enable sl repo mirrorlist':
          command => 'sed -i \'s/#\(mirrorlist.*sl-base-.*\)/\1/g\' /etc/yum.repos.d/sl.repo',
        } ->
        package { 'yum-plugin-fastestmirror':
          ensure => latest,
          provider => 'yum',
          notify => [
            Exec['yum clean all'],
            Exec['yum update'],
          ],
        }
      }
    }
    else {
      # Remove all FastestMirror yum plugin.
      exec { 'remove yum-plugin-fastestmirror':
        command => 'yum -y -d 0 -e 0 remove yum-plugin-fastestmirror',
        notify => [
          Exec['yum clean all'],
          Exec['yum update'],
        ],
      }
    }

    if ($epel_repo) {
      if ($epel_repo_status != 'enabled') {
        # A helper repository that helps to install the right EPEL repository.
        # @see http://stackoverflow.com/a/14155303
        yumrepo { 'epel-bootstrap':
          descr    => "EPEL Bootstrap",
          mirrorlist  => "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-\$releasever&arch=\$basearch",
          enabled  => 1,
          gpgcheck => 0,
          failovermethod => 'priority',
          before => [
            Package['epel-release'],
          ],
        }

        package { 'epel-release':
          ensure => installed,
          provider => 'yum',
          before => [
            Exec['disable epel-bootstrap'],
          ],
        }

        exec { 'disable epel-bootstrap':
          command => 'yum-config-manager --disable epel-bootstrap',
          notify => [
            Exec['yum clean all'],
            Exec['yum update'],
          ],
        }
      }
    }
    else {
      # Remove all EPEL repositories
      exec { 'remove epel repo':
        command => 'yum -y -d 0 -e 0 remove epel-release',
        notify => [
          Exec['yum clean all'],
          Exec['yum update'],
        ],
      }
    }
  }
}
