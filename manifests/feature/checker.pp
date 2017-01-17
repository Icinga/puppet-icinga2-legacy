# == Class: icinga2::feature::checker
#
# Provides the check scheduler of Icinga 2.
#
class icinga2::feature::checker (
    $concurrent_checks = undef,
) {

  if $concurrent_checks {
    validate_integer($concurrent_checks)
  }
  ::icinga2::feature { 'checker':
    content => template('icinga2/feature/checker.conf.erb'),
  }
}
