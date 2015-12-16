# == Defined type: icinga2::object::endpoint
#
# This is a defined type for Icinga 2 apply objects that create EndPoint
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/configuring-icinga2#objecttype-endpoint
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::endpoint (
  $host         = undef,
  $port         = undef,
  $log_duration = undef,
  $target_dir   = '/etc/icinga2/objects/endpoints',
  $file_name    = "${name}.conf",
) {

  if ! defined(Class['icinga2']) {
    fail('You must include the icinga2 base class before using any icinga2 defined resources')
  }

  ensure_resource('icinga2::config::objectdir', 'endpoints')

  validate_absolute_path($target_dir)
  if $host {
    validate_string($host)
  }
  if $port {
    validate_re($port, '^\d{1,5}$')
  }
  if $log_duration {
    validate_string($log_duration)
  }

  file { "icinga2 object endpoint ${name}":
    ensure  => file,
    path    => "${target_dir}/${file_name}",
    owner   => $::icinga2::config_owner,
    group   => $::icinga2::config_group,
    mode    => $::icinga2::config_mode,
    content => template('icinga2/object/endpoint.conf.erb'),
  }

  if $::icinga2::manage_service {
    File["icinga2 object endpoint ${name}"] ~> Class['::icinga2::service']
  }

}
