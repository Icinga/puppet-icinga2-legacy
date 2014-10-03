# enable/disable icinga2 features
define icinga2::server::feature (
  $feature_name = $name,
  $ensure = 'present',
) {
  validate_re($ensure, '^(present|absent)$',
    "${ensure} is not supported for ensure. Allowed values are 'present' and 'absent'.")

  case $ensure {
    'present': {
      exec { "icinga2_enable_feature_${feature_name}":
        path    => '/bin:/sbin:/usr/bin:/usr/sbin',
        command => "icinga2-enable-feature ${feature_name}",
        creates => "/etc/icinga2/features-enabled/${feature_name}.conf",
        #onlyif  => "[ -f /etc/icinga2/features-available/${feature_name}.conf ]",
        user    => 'root',
        notify  => Service[$icinga2::params::icinga2_server_service_name],
      }
    }
    'absent': {
      exec { "icinga2_disable_feature_${feature_name}":
        path    => '/bin:/sbin:/usr/bin:/usr/sbin',
        command => "icinga2-disable-feature ${feature_name}",
        onlyif  => "[ -f /etc/icinga2/features-enabled/${feature_name}.conf ]",
        user    => 'root',
        notify  => Service[$icinga2::params::icinga2_server_service_name],
      }
    }
    default: { fail("Unknown ensure: ${ensure}") }
  }
}
