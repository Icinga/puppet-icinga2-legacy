# == Class: icinga2::feature::influxdbwriter
#
# Manage and enable the InfluxDB writer of Icinga2
#
# Also see the defined type icinga2::object::influxdbwriter we are using.
#
class icinga2::feature::influxdbwriter (
  $password,
  $host                 = 'localhost',
  $port                 = undef,
  $user                 = 'icinga2',
  $database             = 'icinga2',
  $thresholds           = true,
  $metadata             = true,
  $ssl_enable           = true,
) {

  ::icinga2::object::influxdbwriter { 'influxdb':
    host             => $host,
    port             => $port,
    user             => $user,
    password         => $password,
    database         => $database,
    thresholds       => $thresholds,
    metadata         => $metadata,
    ssl_enable       => $ssl_enable,
    target_file_name => 'influxdb.conf',
    target_dir       => '/etc/icinga2/features-available',
  }
  -> ::icinga2::feature { 'influxdb':
    manage_file => false,
  }
}
