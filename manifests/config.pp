# == Class: icinga2::config
#
# Managing the basis config file and paths of Icinga2.

class icinga2::config(
  $config_owner                 = $icinga2::params::config_owner,
  $config_group                 = $icinga2::params::config_group,
  $config_mode                  = $icinga2::params::config_mode,
  $purge_unmanaged_object_files = $icinga2::params::purge_unmanaged_object_files,
  $main_config_template         = undef,
  $main_config_source           = undef,
  $main_config_content          = undef,
) inherits icinga2::params {

  validate_string($config_owner)
  validate_string($config_group)
  validate_string($config_mode)
  validate_bool($purge_unmanaged_object_files)

  $main_config_template_default = 'icinga2/icinga2.conf.erb'

  if count([$main_config_content, $main_config_source, $main_config_template]) > 1 {
    fail('You cannot specify more than one of the $main_config_ parameters!')
  }

  if $main_config_template {
    validate_string($main_config_template)
    $main_config_content_rel = template($main_config_template)
  }
  elsif $main_config_source {
    validate_string($main_config_source)
  }
  elsif $main_config_content {
    $main_config_content_rel = $main_config_content
  }
  else {
    $main_config_content_rel = template($main_config_template_default)
  }

  if $purge_unmanaged_object_files == true {
    $recurse_objects = true
    $purge_objects = true
    $force_purge = true
  }
  else {
    $recurse_objects = false
    $purge_objects = false
    $force_purge = true
  }

  File {
    owner  => $config_owner,
    group  => $config_group,
    mode   => $config_mode,
  }

  $directories = [
    '/etc/icinga2',
    '/etc/icinga2/conf.d/',
    '/etc/icinga2/features-available',
    '/etc/icinga2/features-enabled',
    '/etc/icinga2/pki',
    '/etc/icinga2/scripts',
    '/etc/icinga2/zones.d',
  ]

  file { $directories:
    ensure => directory,
  }

  file { '/etc/icinga2/icinga2.conf':
    ensure  => file,
    content => $main_config_content_rel,
    source  => $main_config_source,
  }

  # TODO: zones.conf

  #File and directory resources for the object directories that can be used to hold different
  #types of configuration objects
  file { '/etc/icinga2/objects/':
    ensure  => directory,
    recurse => $recurse_objects,
    purge   => $purge_objects,
    force   => $force_purge
  }

  # TODO: move the following definitions into the object handling
  $object_directories = [
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
    '/etc/icinga2/objects/externalcommandlisteners',
    '/etc/icinga2/objects/compatloggers',
    '/etc/icinga2/objects/checkresultreaders',
    '/etc/icinga2/objects/checkercomponents',
    '/etc/icinga2/objects/notificationcomponents',
    '/etc/icinga2/objects/fileloggers',
    '/etc/icinga2/objects/syslogloggers',
    '/etc/icinga2/objects/icingastatuswriters',
    '/etc/icinga2/objects/apilisteners',
    '/etc/icinga2/objects/endpoints',
    '/etc/icinga2/objects/zones',
    '/etc/icinga2/objects/applys',
    '/etc/icinga2/objects/templates',
    '/etc/icinga2/objects/constants',
  ]

  file { $object_directories:
    ensure => directory,
  }

}

# vi: ts=2 sw=2 expandtab :
