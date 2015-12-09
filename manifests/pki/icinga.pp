# == Class: icinga2::pki::icinga
#
# Takes care about requesting SSL certificates for the Icinga daemon
#
class icinga2::pki::icinga (
  $ticket_salt,
  $icinga_ca_host,
  $icinga_ca_port = undef,
  $hostname       = $::fqdn,
) {

  validate_string($ticket_salt)
  validate_string($icinga_ca_host)

  if $icinga_ca_port {
    validate_numeric($icinga_ca_port)
    $_icinga_ca_port = " --port '${icinga_ca_port}'"
  }
  else {
    $_icinga_ca_port = ''
  }

  $ticket_id = icinga2_ticket_id($::fqdn, $ticket_salt)

  $pki_dir = '/etc/icinga2/pki'
  $ca = "${pki_dir}/ca.crt"
  $key = "${pki_dir}/${hostname}.key"
  $cert = "${pki_dir}/${hostname}.crt"
  $trusted_cert = "${pki_dir}/trusted-cert.crt"

  Exec {
    user => 'root',
    path => $::path,
  }
  File {
    ensure => file,
    owner  => $::icinga2::config_owner,
    group  => $::icinga2::config_owner,
    mode   => '0644',
  }

  exec { 'icinga2 pki create key':
    command => "icinga2 pki new-cert --cn '${hostname}' --key '${key}' --cert '${cert}'",
    creates => $key,
  } ->
  file {
    $key:
      mode => '0600';
    $cert:
  } ->

  exec { 'icinga2 pki get trusted-cert':
    command => "icinga2 pki save-cert --host '${icinga_ca_host}'${icinga_ca_port} --key '${key}' --cert '${cert}' --trustedcert '${trusted_cert}'",
    creates => $trusted_cert,
  } ->
  file { $trusted_cert:
  } ->

  exec { 'icinga2 pki request':
    command => "icinga2 pki request --host '${icinga_ca_host}'${icinga_ca_port} --ca '${ca}' --key '${key}' --cert '${cert}' --trustedcert '${trusted_cert}' --ticket '${ticket_id}'",
    creates => $ca,
  } ->
  file { $ca:
  }

  include ::icinga2::feature::api

  # ordering of this class
  Class['::icinga2::config'] -> Class['::icinga2::pki::icinga'] ~> Class['icinga2::service']
}