# == Class: icinga2::service
#
# This class manages the Icinga 2 daemon.
#
class icinga2::service {
  $config_stamp = '/var/lib/icinga2/.puppet-config-stamp'

  Exec {
    path => $::path,
    user => 'root',
  }

  exec { 'icinga2 config stamp':
    command     => "touch '${config_stamp}'",
    refreshonly => true,
  } ~>

  exec { 'icinga2 daemon config test':
    command => 'icinga2 daemon -C',
    onlyif  => "test '${config_stamp}' -nt '${::icinga2::pid_file}'",
  } ~>

  service { 'icinga2':
    ensure     => running,
    enable     => true,
    hasrestart => true,
  }
}

