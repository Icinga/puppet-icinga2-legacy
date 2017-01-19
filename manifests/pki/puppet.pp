# == Class: icinga2::pki::puppet
#
# Provide PKI certificates for Icinga2 from the Puppet agent.
#
class icinga2::pki::puppet(
  $ca_path     = "${::icinga2::config_dir}/pki/ca.crt",
  $ca_source   = "${::icinga2::puppet_ssldir}/certs/ca.pem",
  $cert_path   = "${::icinga2::config_dir}/pki/${::fqdn}.crt",
  $cert_source = "${::icinga2::puppet_ssldir}/certs/${::fqdn}.pem",
  $key_path    = "${::icinga2::config_dir}/pki/${::fqdn}.key",
  $key_source  = "${::icinga2::puppet_ssldir}/private_keys/${::fqdn}.pem",
  $crl_path    = "${::icinga2::config_dir}/pki/crl.pem",
  $crl_source  = "${::icinga2::puppet_ssldir}/crl.pem",
) {

  File {
    owner  => $::icinga2::config_owner,
    group  => $::icinga2::config_group,
    mode   => $::icinga2::config_mode,
  }

  file { 'icinga2-pki-ca':
    ensure => file,
    path   => $ca_path,
    source => $ca_source,
  }

  file { 'icinga2-pki-cert':
    ensure => file,
    path   => $cert_path,
    source => $cert_source,
  }

  file { 'icinga2-pki-key':
    ensure => file,
    path   => $key_path,
    source => $key_source,
  }

  if $crl_path {
    validate_absolute_path($crl_path)

    file { 'icinga2-pki-crl':
      ensure => file,
      path   => $crl_path,
      source => $crl_source,
    }
  }

  # ordering of this class
  Class['::icinga2::config'] -> Class['::icinga2::pki::puppet']
  if $::icinga2::manage_service {
    Class['::icinga2::pki::puppet'] ~> Class['icinga2::service']
  }

}
