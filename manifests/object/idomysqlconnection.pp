# == Defined type: icinga2::object::idomysqlconnection
#
# This is a defined type for Icinga 2 IDO MySQL connection objects.
#
define icinga2::object::idomysqlconnection (
  $object_name          = $name,
  $host                 = 'localhost',
  $port                 = undef,
  $user                 = 'icinga',
  $password             = 'icinga',
  $database             = 'icinga',
  $table_prefix         = 'icinga_',
  $instance_name        = 'default',
  $instance_description = undef,
  $enable_ha            = true,
  $cleanup              = {
    acknowledgements_age           => 0,
    commenthistory_age             => 0,
    contactnotifications_age       => 0,
    contactnotificationmethods_age => 0,
    downtimehistory_age            => 0,
    eventhandlers_age              => 0,
    externalcommands_age           => 0,
    flappinghistory_age            => 0,
    hostchecks_age                 => 0,
    logentries_age                 => 0,
    notifications_age              => 0,
    processevents_age              => 0,
    statehistory_age               => 0,
    servicechecks_age              => 0,
    systemcommands_age             => 0,
  },
  $categories      = [],
  $target_file     = "/etc/icinga2/conf.d/${name}.conf",
  $refresh_service = $::icinga2::manage_service,
) {

  if ! defined(Class['icinga2']) {
    fail('You must include the icinga2 base class before using any icinga2 defined resources')
  }

  validate_string($object_name)
  validate_string($host)
  validate_string($user)
  validate_string($password)
  validate_string($database)
  validate_string($table_prefix)
  validate_string($instance_name)
  validate_bool($enable_ha)
  validate_hash($cleanup)
  validate_array($categories)
  validate_absolute_path($target_file)
  validate_bool($refresh_service)

  Class['icinga2::config'] ->
  file { "icinga2 object idomysqlconnection ${title}":
    ensure  => file,
    path    => $target_file,
    owner   => $icinga2::params::config_owner,
    group   => $icinga2::params::config_group,
    mode    => $icinga2::params::config_mode,
    content => template('icinga2/object/idomysqlconnection.conf.erb'),
  }

  if $refresh_service == true {
    File["icinga2 object idomysqlconnection ${title}"] ~> Class['icinga2::service']
  }

}
