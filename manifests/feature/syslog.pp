# == Class: icinga2::feature::syslog
#
# Manage and enable syslog of Icinga2
#
class icinga2::feature::syslog (
  $severity = 'warning',
) {

  validate_re($severity, '^(debug|notice|information|warning|critical)$')
  ::icinga2::feature { 'syslog':
    content => template('icinga2/feature/syslog.conf.erb'),
  }
}
