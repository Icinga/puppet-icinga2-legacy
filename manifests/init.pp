# == Class: icinga2
#
# This module installs and configures Icinga 2 monitoring system.
#
# You can enable/disable certain parts of the module via parameters.
#
# Icinga 2 can server different roles like server, satellite or agent. Which
# are only differnt in how you configure the daemon.
#
# Please see the README for details on how to use this module.
#
class icinga2 (
  $manage_repos                 = $icinga2::params::manage_repos,
  $manage_service               = $icinga2::params::manage_service,
  $use_debmon_repo              = $icinga2::params::use_debmon_repo,
  $package_provider             = $icinga2::params::package_provider,
  $icinga2_package              = $icinga2::params::icinga2_package,
  $install_nagios_plugins       = $icinga2::params::install_nagios_plugins,
  $install_mail_utils_package   = $icinga2::params::install_mail_utils_package,
  $enabled_features             = $icinga2::params::enabled_features,
  $disabled_features            = $icinga2::params::disabled_features,
  $purge_unmanaged_object_files = $icinga2::params::purge_unmanaged_object_files
) inherits icinga2::params {

  # Do some validation of parameters so we know we have the right data types:
  validate_bool($manage_repos)
  validate_bool($use_debmon_repo)
  validate_string($package_provider)
  validate_string($icinga2_package)
  validate_bool($install_nagios_plugins)

  class {'::icinga2::install':} ~>
  class {'::icinga2::config':} ~>
  class {'::icinga2::features':
    enabled_features  => $enabled_features,
    disabled_features => $disabled_features,
  } ~>
  Class['icinga2']

  if $manage_service == true {
    Class['icinga2::config'] ~>
    class {'::icinga2::service':} ->
    Class['icinga2']
  }

}
