# == Defined type: icinga2::object::apiuser
#
# This is a defined type for Icinga 2 apply objects that create ApiUser
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/object-types#objecttype-apiuser
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::apiuser (
  $password    = undef,
  $client_cn   = undef,
  $permissions = ['*'],
  $target_dir  = '/etc/icinga2/objects/apiusers',
  $file_name   = "${name}.conf",
) {

  if ! defined(Class['icinga2']) {
    fail('You must include the icinga2 base class before using any icinga2 defined resources')
  }

  ensure_resource('icinga2::config::objectdir', 'apiusers')

  validate_absolute_path($target_dir)
  validate_array($permissions)
  if $client_cn {
    validate_string($client_cn)
  }
  if $password {
    validate_string($password)
  }

  file { "${target_dir}/${file_name}":
    ensure  => file,
    owner   => $::icinga2::config_owner,
    group   => $::icinga2::config_group,
    mode    => $::icinga2::config_mode,
    content => template('icinga2/object/apiuser.conf.erb'),
  }

  if $::icinga2::manage_service {
    File["${target_dir}/${file_name}"] ~> Class['::icinga2::service']
  }

}
