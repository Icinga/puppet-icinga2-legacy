# == Class: icinga2::feature::graphite
#
# Manage and enable graphite output for Icinga2
#
class icinga2::feature::graphite (
  $graphite_host = undef,
  $graphite_port = undef,
) {

  ::icinga2::feature { 'graphite':
    content => template('icinga2/feature/graphite.conf.erb'),
  }
}
