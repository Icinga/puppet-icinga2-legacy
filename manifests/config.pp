# == Class: icinga2::config
#
# Manages the config environment of Icinga 2.
#
class icinga2::config {
  File {
    owner => $::icinga2::config_owner,
    group => $::icinga2::config_group,
    mode  => $::icinga2::config_mode,
  }

  # maintained directories
  file {
    [
      '/etc/icinga2',
      '/etc/icinga2/pki',
      '/etc/icinga2/scripts',
      '/etc/icinga2/features-available',
    ]:
      ensure => directory,
  }

  # TODO: temporary until we provide some default templates
  file {
    [
      '/etc/icinga2/conf.d',
    ]:
      ensure  => directory,
      purge   => $::icinga2::purge_confd,
      recurse => $::icinga2::purge_confd,
      force   => $::icinga2::purge_confd,
  }

  file {
    [
      '/etc/icinga2/features-enabled',
      '/etc/icinga2/objects',
      '/etc/icinga2/zones.d',
    ]:
      ensure  => directory,
      purge   => $::icinga2::purge_configs,
      recurse => $::icinga2::purge_configs,
      force   => $::icinga2::purge_configs,
  }

  file { '/etc/icinga2/icinga2.conf':
    ensure  => file,
    content => template($::icinga2::config_template),
  }

  # maintained object directories
  file {
    [
      '/etc/icinga2/objects/hosts',
      '/etc/icinga2/objects/hostgroups',
      '/etc/icinga2/objects/services',
      '/etc/icinga2/objects/servicegroups',
      '/etc/icinga2/objects/users',
      '/etc/icinga2/objects/usergroups',
      '/etc/icinga2/objects/checkcommands',
      '/etc/icinga2/objects/notificationcommands',
      '/etc/icinga2/objects/eventcommands',
      '/etc/icinga2/objects/notifications',
      '/etc/icinga2/objects/timeperiods',
      '/etc/icinga2/objects/scheduleddowntimes',
      '/etc/icinga2/objects/dependencies',
      '/etc/icinga2/objects/perfdatawriters',
      '/etc/icinga2/objects/graphitewriters',
      '/etc/icinga2/objects/idomysqlconnections',
      '/etc/icinga2/objects/idopgsqlconnections',
      '/etc/icinga2/objects/livestatuslisteners',
      '/etc/icinga2/objects/statusdatawriters',
      '/etc/icinga2/objects/applys',
      '/etc/icinga2/objects/applys_scheduleddowntimes',
      '/etc/icinga2/objects/templates',
      '/etc/icinga2/objects/constants',
    ]:
      ensure  => directory,
      purge   => $::icinga2::purge_configs,
      recurse => $::icinga2::purge_configs,
      force   => $::icinga2::purge_configs,
  }

  file { '/etc/icinga2/zones.conf':
    ensure  => file,
    content => template('icinga2/zones.conf.erb'),
  }

}
