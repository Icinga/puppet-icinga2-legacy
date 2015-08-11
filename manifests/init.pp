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
  $config_template                        = $::icinga2::params::config_template,
  $default_features                       = true,
  $db_type                                = $::icinga2::params::db_type,
  $db_host                                = 'localhost',
  $db_port                                = undef,
  $db_name                                = $::icinga2::params::db_name,
  $db_user                                = $::icinga2::params::db_user,
  $db_pass                                = $::icinga2::params::db_pass,
  $db_schema                              = undef,
  $manage_database                        = false,
  $manage_repos                           = $::icinga2::params::manage_repos,
  $manage_service                         = $::icinga2::params::manage_service,
  $use_debmon_repo                        = $::icinga2::params::use_debmon_repo,
  $package_provider                       = $::icinga2::params::package_provider,
  $icinga2_package                        = $::icinga2::params::icinga2_package,
  $install_nagios_plugins                 = $::icinga2::params::install_nagios_plugins,
  $install_mail_utils_package             = $::icinga2::params::install_mail_utils_package,
  $purge_configs                          = true,
  $purge_confd                            = false,
  $nrpe_plugin_libdir                     = $::icinga2::params::nrpe_plugin_libdir,
  $nrpe_allowed_hosts                     = $::icinga2::params::nrpe_allowed_hosts,
  $nagios_plugin_packages                 = $::icinga2::params::nagios_plugin_packages,
  $nagios_plugin_package_install_options  = $::icinga2::params::nagios_plugin_package_install_options,
  $nrpe_pid_file_path                     = $::icinga2::params::nrpe_pid_file_path,

  $checkplugin_libdir                     = $::icinga2::params::checkplugin_libdir,
  $client_plugin_package_install_options  = $::icinga2::params::client_plugin_package_install_options,
  $config_group                           = $::icinga2::params::config_group,
  $config_mode                            = $::icinga2::params::config_mode,
  $config_owner                           = $::icinga2::params::config_owner,
  $db_schema_mysql                        = $::icinga2::params::db_schema_mysql,
  $db_schema_pgsql                        = $::icinga2::params::db_schema_pgsql,
  $icinga2_client_packages                = $::icinga2::params::icinga2_client_packages,
  $icinga2_daemon_name                    = $::icinga2::params::icinga2_daemon_name,
  $nrpe_allow_command_argument_processing = $::icinga2::params::nrpe_allow_command_argument_processing,
  $nrpe_command_timeout                   = $::icinga2::params::nrpe_command_timeout,
  $nrpe_config_basedir                    = $::icinga2::params::nrpe_config_basedir,
  $nrpe_connection_timeout                = $::icinga2::params::nrpe_connection_timeout,
  $nrpe_daemon_name                       = $::icinga2::params::nrpe_daemon_name,
  $nrpe_debug_level                       = $::icinga2::params::nrpe_debug_level,
  $nrpe_group                             = $::icinga2::params::nrpe_group,
  $nrpe_listen_port                       = $::icinga2::params::nrpe_listen_port,
  $nrpe_log_facility                      = $::icinga2::params::nrpe_log_facility,
  $nrpe_purge_unmanaged                   = $::icinga2::params::nrpe_purge_unmanaged,
  $nrpe_user                              = $::icinga2::params::nrpe_user,

) inherits ::icinga2::params {
  # TODO: temporary parameter until we provide some default templates
  validate_bool($purge_confd)
  if $purge_confd {
    warning('icinga2::purge_confd is a temporary parameter and will be removed again!')
  }

  validate_bool($manage_database)
  validate_bool($manage_service)
  validate_bool($manage_repos)
  validate_bool($use_debmon_repo)
  validate_string($package_provider)
  validate_string($icinga2_package)
  validate_bool($install_nagios_plugins)

  if $manage_repos != false {
    include "::icinga2::repo::${package_provider}"
    Class["::icinga2::repo::${package_provider}"] ->
    Class['::icinga2::install']
  }
  anchor {'icinga2::start':} ->
  class {'::icinga2::install':} ~>
  class {'::icinga2::config':} ~>
  class {'::icinga2::features': } ~>
  anchor {'icinga2::end':}

  if $manage_service == true {
    Class['icinga2::config'] ~>
    class {'::icinga2::service':} ->
    Anchor['icinga2::end']
  }

  if $manage_database == true {
    Class['icinga2::features'] ->
    class {'::icinga2::database':
    } -> Anchor['icinga2::end']

    if $manage_service {
      Class['icinga2::database'] ~> Class['icinga2::service']
    }
  }
}

