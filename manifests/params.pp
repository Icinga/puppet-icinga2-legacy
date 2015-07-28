# == Class: icinga2::params
#
# This class contains config options and settings for use elsewhere in the module.
#
# === Parameters
#
# See the inline comments.
#
class icinga2::params {

  ##############################
  # Icinga 2 common parameters
  ##############################

  #This section has parameters that are used by both the node and server subclasses

  #Whether to manage the package repositories
  $manage_repos = true
  $use_debmon_repo = false

  #Whether to install the plugin packages when the icinga2::server class is applied:
  $install_nagios_plugins = true

  #whether to install packages that provide the 'mail' binary
  $install_mail_utils_package = false

  $icinga2_daemon_name = 'icinga2'
  $config_template = 'icinga2/icinga2.conf.erb'
  $manage_service = true

  #Database paramters
  $db_type = 'pgsql'
  $db_name = 'icinga2_data'
  $db_user = 'icinga2'
  $db_pass = 'password'

  # the schema is currently not OS specific
  $db_schema_mysql = '/usr/share/icinga2-ido-mysql/schema/mysql.sql'
  $db_schema_pgsql = '/usr/share/icinga2-ido-pgsql/schema/pgsql.sql'

  #Whether to install the plugin packages when the icinga2::server class is applied:
  $server_install_nagios_plugins = true


  ##############################
  # Icinga 2 client parameters
  ##############################

  ##################
  # Icinga 2 client settings
  $nrpe_listen_port        = '5666'
  $nrpe_log_facility       = 'daemon'
  $nrpe_debug_level        = '0'
  #in seconds:
  $nrpe_command_timeout    = '60'
  #in seconds:
  $nrpe_connection_timeout = '300'
  #Note: because we use .join in the nrpe.cfg.erb template, this value *must* be an array
  $nrpe_allowed_hosts      = ['127.0.0.1']
  #Determines whether or not the NRPE daemon will allow clients to specify arguments to commands that are executed
  # *** ENABLING THIS OPTION IS A SECURITY RISK! ***
  # Defaults to NOT allow command arguments
  $nrpe_allow_command_argument_processing = '0'

  # Whether or not to purge nrpe config files NOT managed by Puppet.
  $nrpe_purge_unmanaged = false


  ##################
  # Icinga 2 parameters by OS/release
  case $::operatingsystem {
    'CentOS', 'RedHat', 'Scientific': {

      #Pick the right package provider:
      $icinga2_package = 'icinga2'
      $package_provider = 'yum'

      #Packages for Nagios plugins:
      $nagios_plugin_packages = ['nagios-plugins-nrpe', 'nagios-plugins-all', 'nagios-plugins-openmanage', 'nagios-plugins-check-updates']
      #Package that provides a 'mail' binary:
      $mail_package = 'mailx'
      $nagios_plugin_package_install_options = undef

      #Settings for /etc/icinga2/:
      $config_owner = 'icinga'
      $config_group = 'icinga'
      $config_mode  = '0640'

      # Icinga2 client settings
      $nrpe_config_basedir = '/etc/nagios'
      $nrpe_plugin_libdir  = '/usr/lib64/nagios/plugins'
      $checkplugin_libdir  = '/usr/lib64/nagios/plugins'
      $nrpe_pid_file_path  = '/var/run/nrpe/nrpe.pid'
      $nrpe_user           = 'nrpe'
      $nrpe_group          = 'nrpe'
      $nrpe_daemon_name = 'nrpe'
      $icinga2_client_packages = ['nrpe', 'nagios-plugins-nrpe', 'nagios-plugins-all', 'nagios-plugins-openmanage', 'nagios-plugins-check-updates']

    }
    'Ubuntu': {

      #Pick the right package provider:
      $icinga2_package = 'icinga2'
      $package_provider = 'apt'
      $nagios_plugin_package_install_options = '--no-install-recommends'
      $mail_package = 'mailutils'

      #Settings for /etc/icinga2/:
      $config_owner = 'nagios'
      $config_group = 'nagios'
      $config_mode  = '0640'

      # Icinga2 client settings
      $nrpe_config_basedir  = '/etc/nagios'
      $nrpe_plugin_libdir   = '/usr/lib/nagios/plugins'
      $checkplugin_libdir   = '/usr/lib/nagios/plugins'
      $nrpe_pid_file_path   = '/var/run/nagios/nrpe.pid'
      $nrpe_user            = 'nagios'
      $nrpe_group           = 'nagios'
      $nrpe_daemon_name     = 'nagios-nrpe-server'
      $client_plugin_package_install_options = '--no-install-recommends'

      case $::operatingsystemrelease {
        #Ubuntu 12.04 doesn't have nagios-plugins-common or nagios-plugins-contrib packages available...
        '12.04': {
          #Packages for Nagios plugins:
          $nagios_plugin_packages = ['nagios-plugins', 'nagios-plugins-basic', 'nagios-plugins-standard', 'nagios-snmp-plugins', 'nagios-plugins-extra', 'nagios-nrpe-plugin']
          $icinga2_client_packages = ['nagios-nrpe-server', 'nagios-plugins', 'nagios-plugins-basic', 'nagios-plugins-standard', 'nagios-snmp-plugins', 'nagios-plugins-extra', 'nagios-nrpe-plugin']
        }
        #...but 14.04 does:
        '14.04': {
          $nagios_plugin_packages = [ 'nagios-plugins', 'nagios-plugins-basic', 'nagios-plugins-common', 'nagios-plugins-standard', 'nagios-snmp-plugins', 'nagios-plugins-extra', 'nagios-plugins-contrib', 'nagios-nrpe-plugin']
          $icinga2_client_packages = ['nagios-nrpe-server', 'nagios-plugins', 'nagios-plugins-basic', 'nagios-plugins-common', 'nagios-plugins-standard', 'nagios-snmp-plugins', 'nagios-plugins-extra', 'nagios-plugins-contrib', 'nagios-nrpe-plugin']
        }
        #Fail if we're on any other Ubuntu release:
        default: { fail("${::operatingsystemmajrelease} is not a supported Ubuntu release version!") }
      }

    }

    'Debian': {

      #Pick the right package provider:
      $icinga2_package = 'icinga2'
      $package_provider = 'apt'
      $nagios_plugin_packages = ['nagios-plugins', 'nagios-plugins-basic', 'nagios-plugins-standard', 'nagios-snmp-plugins', 'nagios-plugins-contrib', 'nagios-nrpe-plugin']
      $nagios_plugin_package_install_options = '--no-install-recommends'
      $mail_package = 'mailutils'

      #Settings for /etc/icinga2/:
      $config_owner = 'nagios'
      $config_group = 'nagios'
      $config_mode  = '0640'

      # Icinga2 client settings
      $nrpe_config_basedir  = '/etc/nagios'
      $nrpe_plugin_libdir   = '/usr/lib/nagios/plugins'
      $checkplugin_libdir   = '/usr/lib/nagios/plugins'
      $nrpe_pid_file_path   = '/var/run/nagios/nrpe.pid'
      $nrpe_user            = 'nagios'
      $nrpe_group           = 'nagios'
      $nrpe_daemon_name     = 'nagios-nrpe-server'
      $icinga2_client_packages = ['nagios-nrpe-server', 'nagios-plugins', 'nagios-plugins-basic', 'nagios-plugins-standard', 'nagios-snmp-plugins', 'nagios-plugins-contrib', 'nagios-nrpe-plugin']
      $client_plugin_package_install_options = '--no-install-recommends'
    }
    #Fail if we're on any other OS:
    default: { fail("${::operatingsystem} is not supported!") }
  }
}
