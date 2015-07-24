# Class: icinga2::nrpe
#
# This subclass manages Icinga client components. This class is just the entry point for Puppet to get at the
# icinga2::nrpe:: subclasses.
#
class icinga2::nrpe (
  $icinga2_client_packages                = $::icinga2::icinga2_client_packages,
  $nrpe_allow_command_argument_processing = $::icinga2::allow_command_argument_processing,
  $nrpe_allowed_hosts                     = $::icinga2::nrpe_allowed_hosts,
  $nrpe_command_timeout                   = $::icinga2::nrpe_command_timeout,
  $nrpe_connection_timeout                = $::icinga2::nrpe_connection_timeout,
  $nrpe_debug_level                       = $::icinga2::nrpe_debug_level,
  $nrpe_listen_port                       = $::icinga2::nrpe_listen_port,
  $nrpe_log_facility                      = $::icinga2::nrpe_log_facility,
  $nrpe_purge_unmanaged                   = $::icinga2::nrpe_purge_unmanaged,
) {
  #Do some validation of the parameters that are passed in:
  #validate_array($nrpe_allowed_hosts)
  validate_string($nrpe_log_facility)

  #Apply our classes in the right order. Use the squiggly arrows (~>) to ensure that the
  #class left is applied before the class on the right and that it also refreshes the
  #class on the right.
  class {'::icinga2::nrpe::install':} ~>
  class {'::icinga2::nrpe::config':} ~>
  class {'::icinga2::nrpe::service':} ->
  Class['::icinga2::nrpe']
}

