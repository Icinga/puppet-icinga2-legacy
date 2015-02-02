# == Class: icinga2::node::service
#
# This class mangages the Icinga 2 daemon.
#
# === Parameters
#
# Coming soon...
#
# === Examples
#
# Coming soon...
#

class icinga2::node::service inherits icinga2::node {

  include icinga2::node

  #Service resource for the Icinga 2 daemon:
  service {$icinga2::params::icinga2_daemon_name:
    ensure    => running,
    subscribe => [ Class['icinga2::node::config'], Class['icinga2::features'] ],
  }

}
