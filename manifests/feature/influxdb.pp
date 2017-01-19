# == Class: icinga2::feature::influxdb
#
# Manage and enable influxdb of Icinga2
#
class icinga2::feature::influxdb (
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
  $flush_interval         = '10',
  $flush_threshold        = '1024',
) {
  ::icinga2::object::influxdbwriter { 'influxdb':
    host                   => $host,
    port                   => $port,
    database               => $database,
    username               => $username,
    password               => $password,
    ssl_enable             => $ssl_enable,
    ssl_ca_cert            => $ssl_ca_cert,
    ssl_cert               => $ssl_cert,
    ssl_key                => $ssl_key,
    host_template          => $host_template,
    service_template       => $service_template,
    enable_send_thresholds => $enable_send_thresholds,
    enable_send_metadata   => $enable_send_metadata,
    flush_interval         => $flush_interval,
    flush_threshold        => $flush_threshold,
    target_dir             => '/etc/icinga2/features-available',
  }

  ::icinga2::feature { 'influxdb':
    manage_file => false,
  }
}
