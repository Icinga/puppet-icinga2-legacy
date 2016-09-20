# == Class: icinga2::config::objectdir
#
# Provides a helper defined type, to create directories under `/etc/icinga2/objects`
#
# Example:
#
# ```
# ensure_resource('icinga2::config::objectdir', 'zones')
# ```
#
define icinga2::config::objectdir (
  $path = "/etc/icinga2/objects/${name}",
  $purge = $::icinga2::purge_configs,
) {

  if ! defined(Class['icinga2']) {
    fail('You must include the icinga2 base class before using any icinga2 defined resources')
  }

  Class['icinga2::config'] ->
  file { "icinga2 objectdir ${name}":
    ensure  => directory,
    path    => $path,
    owner   => $::icinga2::config_owner,
    group   => $::icinga2::config_group,
    mode    => $::icinga2::config_mode,
    purge   => $purge,
    recurse => $purge,
    force   => $purge,
  }

}
