# == Class: icinga2::feature::api
#
# Manage and enable the internal API connections between Icinga daemons
#
# By default this features managed the certificate data as well and uses
# the Puppet agent's certificates.
#
class icinga2::feature::api (
  $accept_commands = false,
  $accept_config   = false,
  $manage_pki      = true,
  $ca_path         = '/etc/icinga2/pki/ca.crt',
  $ca_source       = "${::settings::ssldir}/certs/ca.pem",
  $ca_content      = undef,
  $cert_path       = "/etc/icinga2/pki/${::fqdn}.crt",
  $cert_source     = "${::settings::ssldir}/certs/${::fqdn}.pem",
  $cert_content    = undef,
  $key_path        = "/etc/icinga2/pki/${::fqdn}.key",
  $key_source      = "${::settings::ssldir}/private_keys/${::fqdn}.pem",
  $key_content     = undef,
  $crl_path        = '/etc/icinga2/pki/crl.pem',
  $crl_source      = "${::settings::ssldir}/crl.pem",
  $crl_content     = undef,
  $bind_host       = undef,
  $bind_port       = undef,
  $ticket_salt     = false,
) {

  validate_bool($accept_commands)
  validate_bool($accept_config)
  validate_bool($manage_pki)

  validate_absolute_path($ca_path)
  validate_absolute_path($cert_path)
  validate_absolute_path($key_path)

  if $bind_host {
    validate_string($bind_host)
  }
  if $bind_port {
    validate_integer($bind_port)
  }

  if $::icinga2::manage_service {
    $notify = Class['icinga2::service']
  }
  else {
    $notify = undef
  }

  File {
    owner  => $::icinga2::config_owner,
    group  => $::icinga2::config_group,
    mode   => $::icinga2::config_mode,
    notify => $notify,
  }

  if $manage_pki {
    file { 'icinga2-pki-ca':
      ensure  => file,
      path    => $ca_path,
      content => $ca_content,
      source  => $ca_source,
    }

    file { 'icinga2-pki-cert':
      ensure  => file,
      path    => $cert_path,
      content => $cert_content,
      source  => $cert_source,
    }

    file { 'icinga2-pki-key':
      ensure  => file,
      path    => $key_path,
      content => $key_content,
      source  => $key_source,
    }

    if $crl_path {
      validate_absolute_path($crl_path)

      file { 'icinga2-pki-crl':
        ensure  => file,
        path    => $crl_path,
        content => $crl_content,
        source  => $crl_source,
      }
    }
  }

  if $ticket_salt {
    validate_bool($ticket_salt)
  }

  ::icinga2::feature { 'api':
    content => template('icinga2/feature/api.conf.erb'),
  }
}
