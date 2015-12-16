# == Class: icinga2::pki::puppet
#
# Provide PKI certificates for Icinga2 from the Puppet agent.
#
class icinga2::pki::puppet(
  $ca_path     = '/etc/icinga2/pki/ca.crt',
  $ca_source   = "${::settings::ssldir}/certs/ca.pem",
  $cert_path   = "/etc/icinga2/pki/${::fqdn}.crt",
  $cert_source = "${::settings::ssldir}/certs/${::fqdn}.pem",
  $key_path    = "/etc/icinga2/pki/${::fqdn}.key",
  $key_source  = "${::settings::ssldir}/private_keys/${::fqdn}.pem",
  $crl_path    = '/etc/icinga2/pki/crl.pem',
  $crl_source  = "${::settings::ssldir}/crl.pem",
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

  include ::icinga2::feature::api

  # ordering of this class
  Class['::icinga2::config'] -> Class['::icinga2::pki::puppet']
  if $::icinga2::manage_service {
    Class['::icinga2::pki::puppet'] ~> Class['icinga2::service']
  }

}