# == Class: icinga2::feature::mainlog
#
# Manage and enable the default log of Icinga2
#
class icinga2::feature::mainlog (
  $severity = 'information',
  $path     = "${::icinga2::params::i2dirprefix}/var/log/icinga2/icinga2.log"
) {

  validate_string($severity)
  validate_absolute_path($path)

  $object_name = 'mainlog'

  ::icinga2::feature { 'mainlog':
    content => template('icinga2/feature/mainlog.conf.erb'),
  }
}
