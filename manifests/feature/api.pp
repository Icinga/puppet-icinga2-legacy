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
  $ca_path         = '/etc/icinga2/pki/ca.crt',
  $cert_path       = "/etc/icinga2/pki/${::fqdn}.crt",
  $key_path        = "/etc/icinga2/pki/${::fqdn}.key",
  $crl_path        = undef,
  $bind_host       = undef,
  $bind_port       = undef,
  $ticket_salt     = false,
  $hostname        = $::fqdn,
  $manage_zone     = true,
  $parent_zone     = undef,
) {

  validate_bool($accept_commands)
  validate_bool($accept_config)
  validate_bool($manage_zone)

  validate_absolute_path($ca_path)
  validate_absolute_path($cert_path)
  validate_absolute_path($key_path)

  if $bind_host {
    validate_string($bind_host)
  }
  if $bind_port {
    validate_integer($bind_port)
  }

  if $ticket_salt {
    validate_bool($ticket_salt)
  }

  ::icinga2::feature { 'api':
    content => template('icinga2/feature/api.conf.erb'),
  }

  if $manage_zone {
    $endpoints = {
      "${hostname}" => {},
    }
    ::icinga2::object::zone { $hostname:
      parent    => $parent_zone,
      endpoints => $endpoints,
    }

  }

}
