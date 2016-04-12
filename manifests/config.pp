# == Class: icinga2::config
#
# Manages the config environment of Icinga 2.
#
class icinga2::config {
  validate_bool($::icinga2::default_features)

  File {
    owner => $::icinga2::config_owner,
    group => $::icinga2::config_group,
    mode  => $::icinga2::config_mode,
  }

  # maintained directories
  file {
    [
      "${::icinga2::params::i2dirprefix}/etc/icinga2",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/pki",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/scripts",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/features-available",
    ]:
      ensure => directory,
  }

  # TODO: temporary until we provide some default templates
  file {
    [
      "${::icinga2::params::i2dirprefix}/etc/icinga2/conf.d",
    ]:
      ensure  => directory,
      purge   => $::icinga2::purge_confd,
      recurse => $::icinga2::purge_confd,
      force   => $::icinga2::purge_confd,
  }

  file {
    [
      "${::icinga2::params::i2dirprefix}/etc/icinga2/features-enabled",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/zones.d",
    ]:
      ensure  => directory,
      purge   => $::icinga2::purge_configs,
      recurse => $::icinga2::purge_configs,
      force   => $::icinga2::purge_configs,
  }

  file { "${::icinga2::params::i2dirprefix}/etc/icinga2/icinga2.conf":
    ensure  => file,
    content => template($::icinga2::config_template),
  }

  # maintained object directories
  file {
    [
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/hosts",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/hostgroups",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/services",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/servicegroups",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/users",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/usergroups",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/checkcommands",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/notificationcommands",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/eventcommands",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/notifications",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/timeperiods",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/scheduleddowntimes",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/dependencies",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/perfdatawriters",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/graphitewriters",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/idomysqlconnections",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/idopgsqlconnections",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/livestatuslisteners",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/statusdatawriters",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/applys",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/applys_scheduleddowntimes",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/templates",
      "${::icinga2::params::i2dirprefix}/etc/icinga2/objects/constants",
    ]:
      ensure  => directory,
      purge   => $::icinga2::purge_configs,
      recurse => $::icinga2::purge_configs,
      force   => $::icinga2::purge_configs,
  }

  file { "${::icinga2::params::i2dirprefix}/etc/icinga2/zones.conf":
    ensure  => file,
    content => template('icinga2/zones.conf.erb'),
  }

  if $::icinga2::default_features {
    include ::icinga2::feature::checker
    include ::icinga2::feature::notification
    include ::icinga2::feature::mainlog
  }

}
