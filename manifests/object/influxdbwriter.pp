# == Defined type: icinga2::object::influxdbwriter
#
# This is a defined type for Icinga 2 influxdb writer
#
define icinga2::object::influxdbwriter (
  $password,
  $object_name          = $name,
  $host                 = 'localhost',
  $port                 = 8086,
  $user                 = 'icinga2',
  $database             = 'icinga2',
  $thresholds           = true,
  $metadata             = true,
  $target_file_name     = "${name}.conf",
  $target_dir           = '/etc/icinga2/objects/influxdbwriter',
  $refresh_service      = $::icinga2::manage_service,
) {

  if ! defined(Class['icinga2']) {
    fail('You must include the icinga2 base class before using any icinga2 defined resources')
  }

  validate_string($object_name)
  validate_string($host)
  validate_string($user)
  validate_string($password)
  validate_string($database)
  validate_bool($thresholds)
  validate_bool($metadata)

  Class['icinga2::config'] ->
  file { "${target_dir}/${target_file_name}":
    ensure  => file,
    owner   => $::icinga2::config_owner,
    group   => $::icinga2::config_group,
    mode    => $::icinga2::config_mode,
    content => template('icinga2/object/influxdbwriter.conf.erb'),
  }

  if $refresh_service == true {
    File["${target_dir}/${target_file_name}"] ~> Class['::icinga2::service']
  }

}
