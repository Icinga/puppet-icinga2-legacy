# == Defined type: icinga2::object::influxdbwriter
#
#  This is a defined type for Icinga 2 InfluxdbWriter objects.
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/object-types#objecttype-influxdbwriter
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::influxdbwriter (
  $host                   = '127.0.0.1',
  $port                   = 8086,
  $database               = 'icinga2',
  $username               = undef,
  $password               = undef,
  $ssl_enable             = undef,
  $ssl_ca_cert            = undef,
  $ssl_cert               = undef,
  $ssl_key                = undef,
  $host_template          = undef,
  $service_template       = undef,
  $enable_send_thresholds = undef,
  $enable_send_metadata   = undef,
  $flush_interval         = 10,
  $flush_threshold        = 1024,
  $target_dir             = '/etc/icinga2/objects/influxdbwriters',
  $file_name              = "${name}.conf",
) {
  # Do some validation
  validate_string($host)
  validate_string($database)
  validate_integer($port)
  validate_integer($flush_interval)
  validate_integer($flush_threshold)

  if $username != undef {
    validate_string($username)
  }

  if $password != undef {
    validate_string($password)
  }

  if $ssl_enable != undef {
    validate_bool($ssl_enable)
  }

  if $ssl_ca_cert != undef {
    validate_string($ssl_ca_cert)
  }

  if $ssl_cert != undef {
    validate_string($ssl_cert)
  }

  if $ssl_key != undef {
    validate_string($ssl_key)
  }

  if $enable_send_thresholds != undef {
    validate_bool($enable_send_thresholds)
  }

  if $enable_send_metadata != undef {
    validate_bool($enable_send_metadata)
  }

  file { "${target_dir}/${file_name}":
    ensure  => file,
    owner   => $::icinga2::config_owner,
    group   => $::icinga2::config_group,
    mode    => $::icinga2::config_mode,
    content => template('icinga2/object/influxdbwriter.conf.erb'),
  }

  if $::icinga2::manage_service {
    File["${target_dir}/${file_name}"] ~> Class['::icinga2::service']
  }
}
