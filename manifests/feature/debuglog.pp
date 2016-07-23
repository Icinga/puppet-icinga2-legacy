# == Class: icinga2::feature::debuglog
#
# Manage and enable the debug log of Icinga2
#
class icinga2::feature::debuglog (
  $severity = 'debug',
  $path     = "${::icinga2::var_dir}/log/icinga2/debug.log"
) {

  validate_string($severity)
  validate_absolute_path($path)

  ::icinga2::feature { 'debuglog':
    content => template('icinga2/feature/debuglog.conf.erb'),
  }
}
