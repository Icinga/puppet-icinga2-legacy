# enable/disable icinga2 features
define icinga2::server::feature (
  $feature_name = $name,
  $ensure = present,
) {
  case $ensure {
    'present': { 
      exec { "icinga2_enable_feature_${feature_name}":
        path    => '/bin:/sbin:/usr/bin:/usr/sbin',
        command => "icinga2-enable-feature ${feature_name}",
        unless  => "icinga2-enable-feature | grep Enabled | grep ${feature_name}",
        user    => 'root',
        notify  => Service[$icinga2::params::icinga2_server_service_name],
      }
    }
    'absent': {
      exec { "icinga2_disable_feature_${feature_name}":
        path    => '/bin:/sbin:/usr/bin:/usr/sbin',
        command => "icinga2-disable-feature ${feature_name}",
        onlyif  => "icinga2-enable-feature | grep Enabled | grep ${feature_name}",
        user    => 'root',
        notify  => Service[$icinga2::params::icinga2_server_service_name],
      }
    }
    default: { fail("Unknown ensure: ${ensure}") }
  }
}
