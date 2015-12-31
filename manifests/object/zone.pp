# == Defined type: icinga2::object::host
#
#  This is a defined type for Icinga 2 zone objects.
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/object-types#objecttype-zone
#
# === Parameters
#
# See the inline comments.
#
define icinga2::object::zone(
  $endpoints  = undef,
  $global     = false,
  $parent     = undef,
  $target_dir = '/etc/icinga2/objects/zones',
  $file_name  = "${name}.conf",
) {

  if ! defined(Class['icinga2']) {
    fail('You must include the icinga2 base class before using any icinga2 defined resources')
  }

  ensure_resource('icinga2::config::objectdir', 'zones')

  if $endpoints {
    validate_hash($endpoints)
    $_endpoints = keys($endpoints)

    create_resources('icinga2::object::endpoint', $endpoints)
  }
  else {
    $_endpoints = undef
  }
  if $parent {
    validate_string($parent)
  }
  if $global {
    validate_bool($global)
    if $endpoints or $parent {
      fail('global zones can\'t have endpoints or parents!')
    }
  }

  validate_absolute_path($target_dir)
  validate_string($file_name)

  file { "icinga2 object zone ${name}":
    ensure  => file,
    path    => "${target_dir}/${file_name}",
    owner   => $::icinga2::config_owner,
    group   => $::icinga2::config_group,
    mode    => $::icinga2::config_mode,
    content => template('icinga2/object/zone.conf.erb'),
  }

  if $::icinga2::manage_service {
    File["icinga2 object zone ${name}"] ~> Class['::icinga2::service']
  }

}

