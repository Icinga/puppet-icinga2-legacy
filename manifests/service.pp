# == Class: icinga2::service
#
# This class manages the Icinga 2 daemon.
#
class icinga2::service {
  service { 'icinga2':
    ensure     => running,
    name       => $::icinga2::params::icinga2_daemon_name,
    enable     => true,
    hasrestart => true,
    subscribe  => [ Class['icinga2::config'], Class['icinga2::features'] ],
  }
}

