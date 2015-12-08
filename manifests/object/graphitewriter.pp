# == Defined type: icinga2::object::graphitewriter
#
#  This is a defined type for Icinga 2 GraphiteWriter objects.
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/configuring-icinga2#objecttype-graphitewriter
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::graphitewriter (
  $host                   = '127.0.0.1',
  $port                   = 2003,
  $host_name_template     = undef,
  $service_name_template  = undef,
  # Only avaiable in icinga2 >= 2.4
  $enable_send_thresholds = undef,
  $enable_send_metadata   = undef,
  # This will be only avaiable in some icinga 2 versions for examlple 2.4
  $enable_legacy_mode     = undef,
  # Put the object files this defined type generates in features-available
  # since the Graphite writer feature is one that has to be explicitly enabled.
  $target_dir             = '/etc/icinga2/objects/graphitewriters',
  $file_name              = "${name}.conf",
) {
  # Do some validation
  validate_string($host)

  if $enable_send_thresholds != undef {
    validate_bool($enable_send_thresholds)
  }

  if $enable_send_metadata != undef {
    validate_bool($enable_send_metadata)
  }

  if $enable_legacy_mode != undef {
    validate_bool($enable_legacy_mode)
  }

  file { "${target_dir}/${file_name}":
    ensure  => file,
    owner   => $::icinga2::config_owner,
    group   => $::icinga2::config_group,
    mode    => $::icinga2::config_mode,
    content => template('icinga2/object/graphitewriter.conf.erb'),
  }

  if $::icinga2::manage_service {
    File["${target_dir}/${file_name}"] ~> Class['::icinga2::service']
  }
}
