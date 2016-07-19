# == Defined type: icinga2::object::constant
#
# Just define constant, like in constants.conf
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::constant (
  $value,
  $constant = $name,
  $target_dir = '/etc/icinga2/objects/constants',
  $file_name = "${name}.conf",
  $refresh_service = $::icinga2::manage_service,
) {

  if ! defined(Class['icinga2']) {
    fail('You must include the icinga2 base class before using any icinga2 defined resources')
  }

  validate_string($value)
  validate_string($constant)

  file { "icinga2 object constant ${name}":
    ensure  => file,
    path    => "${target_dir}/${file_name}",
    owner   => $::icinga2::config_owner,
    group   => $::icinga2::config_group,
    mode    => $::icinga2::config_mode,
    content => template('icinga2/object/constant.conf.erb'),
  }

  if $refresh_service == true {
    File["icinga2 object constant ${name}"] ~> Class['::icinga2::service']
  }
}
