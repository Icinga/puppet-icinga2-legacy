# == Class: icinga2::feature::graphite
#
# Manage and enable graphite of Icinga2
#
class icinga2::feature::graphite (
  $host = '127.0.0.1',
  $port = 2003
) {

  icinga2::object::graphitewriter { 'graphite':
    graphite_host => $host,
    graphite_port => $port,
  }
}
