# == Class: icinga2::feature::graphite
#
# Manage and enable graphite of Icinga2
#
class icinga2::feature::graphite (
  $host                   = '127.0.0.1',
  $port                   = 2003,
  $host_name_template     = undef,
  $service_name_template  = undef,
  # Only avaiable in icinga2 >= 2.4
  $enable_send_thresholds = undef,
  $enable_send_metadata   = undef,
  # This will be only avaiable in some icinga 2 versions for example 2.4
  $enable_legacy_mode     = undef,
) {
  ::icinga2::object::graphitewriter { 'graphite':
    host                   => $host,
    port                   => $port,
    host_name_template     => $host_name_template,
    service_name_template  => $service_name_template,
    enable_send_thresholds => $enable_send_thresholds,
    enable_send_metadata   => $enable_send_metadata,
    enable_legacy_mode     => $enable_legacy_mode,
    target_dir             => '/etc/icinga2/features-available',
  }

  ::icinga2::feature { 'graphite':
    manage_file => false,
  }
}
