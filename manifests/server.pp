# == Class: icinga2::server
#
# This module installs and configures the server components for the Icinga 2 monitoring system.
#
# === Parameters
#
# Coming soon...
#
# === Examples
#
# Coming soon...
#

class icinga2::server (
  $manage_repos = $icinga2::params::manage_repos,
  $manage_service = $icinga2::params::manage_service,
  $use_debmon_repo = $icinga2::params::use_debmon_repo,
  $package_provider = $icinga2::params::package_provider,
  $icinga2_package = $icinga2::params::icinga2_package,
  $install_nagios_plugins = $icinga2::params::install_nagios_plugins,
  $install_mail_utils_package = $icinga2::params::install_mail_utils_package,
  $enabled_features = undef,
  $disabled_features = undef,
  $purge_unmanaged_object_files = true,
  #Icinga 2 server specific parameters:
  $server_db_type = $icinga2::params::server_db_type,
  $db_name = $icinga2::params::db_name,
  $db_user = $icinga2::params::db_user,
  $db_password = $icinga2::params::db_pass,
  $db_host = 'localhost',
  $db_port = undef,
) inherits icinga2::params {

  warning('DEPRECATED: The usage of icinga2::server is deprecated and might be removed due to refactoring')

  #Do some validation of parameters so we know we have the right data types:
  validate_bool($manage_repos)
  validate_bool($use_debmon_repo)
  validate_string($server_db_type)
  validate_string($db_name)
  validate_string($db_user)
  validate_string($db_password)
  validate_string($db_host)
  validate_string($db_port)
  validate_string($package_provider)
  validate_string($::icinga2::params::icinga2_server_package)
  validate_bool($::icinga2::params::server_install_nagios_plugins)

  if $enabled_features {
    validate_array($enabled_features)
    $default_features = $enabled_features
  }
  else {
    $default_features = true
  }
  if $disabled_features {
    fail('icinga2::server::disabled_features is no longer supported, please use icinga2::default_features')
  }

  anchor {'icinga2::server::start':} ->
  class {'::icinga2':
    install_mail_utils_package => $install_mail_utils_package,
    install_nagios_plugins     => $install_nagios_plugins,
    purge_configs              => $purge_unmanaged_object_files,
    manage_service             => $manage_service,
    manage_database            => true,
    db_type                    => $server_db_type,
    db_host                    => $db_host,
    db_port                    => $db_port,
    db_name                    => $db_name,
    db_user                    => $db_user,
    db_pass                    => $db_password,
  } ~>
  anchor {'icinga2::server::end':}

}
