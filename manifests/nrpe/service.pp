# Class: icinga2::nrpe::service
#
# This class manges the daemons/services for the server components of Icinga.
#
class icinga2::nrpe::service {
  #Service resource for NRPE.
  #This references the daemon name we defined in the icinga2::params class based on the OS:
  service { 'nrpe':
    ensure    => running,
    name      => $::icinga2::nrpe_daemon_name,
    enable    => true, #Enable the service to start on system boot
    #require  => Package[$::icinga2::icinga2_client_packages],
    subscribe => Class['::icinga2::nrpe::config'], #Subscribe to the client::config class so the service gets restarted if any config files change
  }
}

