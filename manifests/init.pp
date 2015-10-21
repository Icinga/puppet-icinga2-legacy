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
  $install_plugins                        = true,
  $install_mailutils                      = true,
  $purge_configs                          = true,
  $purge_confd                            = false,
  $plugin_packages                        = $::icinga2::params::plugin_packages,
  $plugin_packages_extra                  = [],
  $checkplugin_libdir                     = $::icinga2::params::checkplugin_libdir,
  $config_group                           = $::icinga2::params::config_group,
  $config_mode                            = $::icinga2::params::config_mode,
  $config_owner                           = $::icinga2::params::config_owner,
  $db_schema_mysql                        = $::icinga2::params::db_schema_mysql,
  $db_schema_pgsql                        = $::icinga2::params::db_schema_pgsql,
  $pid_file                               = $::icinga2::params::pid_file,
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

  if $manage_repos == true {
    include icinga2::repo
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
      Class['::icinga2::database'] ~> Class['::icinga2::service']
    }
  }
}

