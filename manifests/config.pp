# == Class: icinga2::config
#
# Manages the config environment of Icinga 2.
#
class icinga2::config {

  assert_private()

  if $purge_unmanaged_object_files == true { # lint:ignore:variable_scope
    $recurse_and_purge = true
  }
  else {
    $recurse_and_purge = false
  }

  File {
    owner => $icinga2::params::config_owner,
    group => $icinga2::params::config_group,
    mode  => $icinga2::params::config_mode,
  }

  # maintained directories
  file {
    '/etc/icinga2':
      ensure => directory;
    '/etc/icinga2/conf.d':
      ensure => directory;
    '/etc/icinga2/features-available':
      ensure => directory;
    '/etc/icinga2/features-enabled':
      ensure => directory;
    '/etc/icinga2/pki':
      ensure => directory;
    '/etc/icinga2/scripts':
      ensure => directory;
    '/etc/icinga2/zones.d':
      ensure => directory;
    '/etc/icinga2/objects':
      ensure  => directory,
      purge   => $recurse_and_purge,
      recurse => $recurse_and_purge,
      force   => $recurse_and_purge;
  }

  file { '/etc/icinga2/icinga2.conf':
    ensure  => file,
    content => template('icinga2/icinga2.conf.erb'),
  }

  # maintained object directories
  file {
    '/etc/icinga2/objects/hosts':
      ensure => directory;
    '/etc/icinga2/objects/hostgroups':
      ensure => directory;
    '/etc/icinga2/objects/services':
      ensure => directory;
    '/etc/icinga2/objects/servicegroups':
      ensure => directory;
    '/etc/icinga2/objects/users':
      ensure => directory;
    '/etc/icinga2/objects/usergroups':
      ensure => directory;
    '/etc/icinga2/objects/checkcommands':
      ensure => directory;
    '/etc/icinga2/objects/notificationcommands':
      ensure => directory;
    '/etc/icinga2/objects/eventcommands':
      ensure => directory;
    '/etc/icinga2/objects/notifications':
      ensure => directory;
    '/etc/icinga2/objects/timeperiods':
      ensure => directory;
    '/etc/icinga2/objects/scheduleddowntimes':
      ensure => directory;
    '/etc/icinga2/objects/dependencies':
      ensure => directory;
    '/etc/icinga2/objects/perfdatawriters':
      ensure => directory;
    '/etc/icinga2/objects/graphitewriters':
      ensure => directory;
    '/etc/icinga2/objects/idomysqlconnections':
      ensure => directory;
    '/etc/icinga2/objects/idopgsqlconnections':
      ensure => directory;
    '/etc/icinga2/objects/livestatuslisteners':
      ensure => directory;
    '/etc/icinga2/objects/statusdatawriters':
      ensure => directory;
    '/etc/icinga2/objects/externalcommandlisteners':
      ensure => directory;
    '/etc/icinga2/objects/checkercomponents':
      ensure => directory;
    '/etc/icinga2/objects/notificationcomponents':
      ensure => directory;
    '/etc/icinga2/objects/fileloggers':
      ensure => directory;
    '/etc/icinga2/objects/apilisteners':
      ensure => directory;
    '/etc/icinga2/objects/endpoints':
      ensure => directory;
    '/etc/icinga2/objects/zones':
      ensure => directory;
    '/etc/icinga2/objects/applys':
      ensure => directory;
    '/etc/icinga2/objects/templates':
      ensure => directory;
    '/etc/icinga2/objects/constants':
      ensure => directory;
  }

}
