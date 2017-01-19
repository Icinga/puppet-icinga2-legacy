# == Class: icinga2::feature::mainlog
#
# Manage and enable the default log of Icinga2
#
class icinga2::feature::mainlog (
  $severity = $::icinga2::mainlog_severity,
  $path     = $::icinga2::mainlog_path,
) {

  validate_string($severity)
  validate_absolute_path($path)

  $object_name = 'mainlog'

  ::icinga2::feature { 'mainlog':
    content => template('icinga2/feature/mainlog.conf.erb'),
  }
}
