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
      $::icinga2::config_dir,
      "${::icinga2::config_dir}/pki",
      "${::icinga2::config_dir}/scripts",
      "${::icinga2::config_dir}/features-available",
    ]:
      ensure => directory,
  }

  # TODO: temporary until we provide some default templates
  file {
    [
      "${::icinga2::config_dir}/conf.d",
    ]:
      ensure  => directory,
      purge   => $::icinga2::purge_confd,
      recurse => $::icinga2::purge_confd,
      force   => $::icinga2::purge_confd,
  }

  file {
    [
      "${::icinga2::config_dir}/features-enabled",
      "${::icinga2::config_dir}/objects",
      "${::icinga2::config_dir}/zones.d",
    ]:
      ensure  => directory,
      purge   => $::icinga2::purge_configs,
      recurse => $::icinga2::purge_configs,
      force   => $::icinga2::purge_configs,
  }

  file { "${::icinga2::config_dir}/icinga2.conf":
    ensure  => file,
    content => template($::icinga2::config_template),
  }

  # maintained object directories
  file {
    [
      "${::icinga2::config_dir}/objects/hosts",
      "${::icinga2::config_dir}/objects/hostgroups",
      "${::icinga2::config_dir}/objects/services",
      "${::icinga2::config_dir}/objects/servicegroups",
      "${::icinga2::config_dir}/objects/users",
      "${::icinga2::config_dir}/objects/usergroups",
      "${::icinga2::config_dir}/objects/checkcommands",
      "${::icinga2::config_dir}/objects/notificationcommands",
      "${::icinga2::config_dir}/objects/eventcommands",
      "${::icinga2::config_dir}/objects/notifications",
      "${::icinga2::config_dir}/objects/timeperiods",
      "${::icinga2::config_dir}/objects/scheduleddowntimes",
      "${::icinga2::config_dir}/objects/dependencies",
      "${::icinga2::config_dir}/objects/perfdatawriters",
      "${::icinga2::config_dir}/objects/graphitewriters",
      "${::icinga2::config_dir}/objects/idomysqlconnections",
      "${::icinga2::config_dir}/objects/idopgsqlconnections",
      "${::icinga2::config_dir}/objects/livestatuslisteners",
      "${::icinga2::config_dir}/objects/statusdatawriters",
      "${::icinga2::config_dir}/objects/applys",
      "${::icinga2::config_dir}/objects/templates",
      "${::icinga2::config_dir}/objects/constants",
    ]:
      ensure  => directory,
      purge   => $::icinga2::purge_configs,
      recurse => $::icinga2::purge_configs,
      force   => $::icinga2::purge_configs,
  }

  file { "${::icinga2::config_dir}/zones.conf":
    ensure  => file,
    content => template('icinga2/zones.conf.erb'),
  }

  if $::icinga2::default_features {
    include ::icinga2::feature::checker
    include ::icinga2::feature::notification
    include ::icinga2::feature::mainlog
  }

}
