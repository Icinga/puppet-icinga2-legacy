# == Class: icinga2::repo
#
# Manages the repository handling for the platforms that support it.  By
# default we notiofy the user of unsupported platforms.
#
class icinga2::repo {
  include icinga2

  case $::osfamily {
    'Debian': {
      include icinga2::repo::apt
      Class['icinga2::repo::apt'] -> Class['icinga2::install']
    }
    'RedHat': {
      if $::operatingsystem == 'Amazon' {
        class { 'icinga2::repo::yum':
          baseurl => 'http://packages.icinga.org/epel/6/release/',
        }
      } else {
        include icinga2::repo::yum
      }
      Class['icinga2::repo::yum'] -> Class['icinga2::install']
    }
    default: {
      notify { "Class[icinga2::repo] does not support ${::osfamily}": }
    }
  }
}
