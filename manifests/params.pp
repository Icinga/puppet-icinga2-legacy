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

  #Whether to install the plugin packages when the icinga2 class is applied:
  $install_nagios_plugins = true

  #whether to install packages that provide the 'mail' binary
  $install_mail_utils_package = false

  $config_template = 'icinga2/icinga2.conf.erb'
  $manage_service = true

  #Database paramters
  $db_type = 'pgsql'
  $db_name = 'icinga2_data'
  $db_user = 'icinga2'
  $db_pass = 'password'

  $pid_file = '/run/icinga2/icinga2.pid'

  $restart_cmd = undef

  ##################
  # Icinga 2 parameters by OS/release
  case $::operatingsystem {
    'CentOS', 'RedHat', 'Scientific', 'OracleLinux', 'Amazon': {

      #Packages for Nagios plugins:
      $plugin_packages = [
        'nagios-plugins-all',
        'nagios-plugins-check-updates',
      ]
      #Package that provides a 'mail' binary:
      $mail_package = 'mailx'

      #Settings for /etc/icinga2/:
      $config_owner = 'icinga'
      $config_group = 'icinga'
      $config_mode  = '0640'

      # Icinga2 client settings
      $checkplugin_libdir  = '/usr/lib64/nagios/plugins'
    }
    'Ubuntu': {

      $plugin_packages = [
        'nagios-plugins',
        'nagios-plugins-basic',
        'nagios-plugins-standard',
        'nagios-snmp-plugins',
      ]
      $mail_package = 'mailutils'

      #Settings for /etc/icinga2/:
      $config_owner = 'nagios'
      $config_group = 'nagios'
      $config_mode  = '0640'

      # Icinga2 client settings
      $checkplugin_libdir   = '/usr/lib/nagios/plugins'
    }

    'Debian': {

      $plugin_packages = [
        'nagios-plugins',
        'nagios-plugins-basic',
        'nagios-plugins-standard',
        'nagios-snmp-plugins',
        'nagios-plugins-contrib',
      ]
      $mail_package = 'mailutils'

      #Settings for /etc/icinga2/:
      $config_owner = 'nagios'
      $config_group = 'nagios'
      $config_mode  = '0640'

      # Icinga2 client settings
      $checkplugin_libdir   = '/usr/lib/nagios/plugins'
    }
    'OpenBSD': {

      $plugin_packages = [
        'monitoring-plugins',
      ]
      $mail_package = undef

      #Settings for /etc/icinga2/:
      $config_owner = 'root'
      $config_group = '_icinga'
      $config_mode  = '0640'

      # Icinga2 client settings
      $checkplugin_libdir   = '/usr/local/libexec/nagios'
    }
    #Fail if we're on any other OS:
    default: { fail("${::operatingsystem} is not supported!") }
  }


  unless $config_dir {
    $config_dir = '/etc/icinga2'
  }

  unless $sbin_dir {
    $sbin_dir = '/usr/sbin'
  }

  unless $share_dir {
    $share_dir = '/usr/share'
  }

  unless $var_dir {
    $var_dir = '/var'
  }

  # Use the fact for the local agents ssldir, if it is not found it will use the masters.
  if $::icinga2_puppet_ssldir {
    $puppet_ssldir = $::icinga2_puppet_ssldir
  }
  else {
    $puppet_ssldir = $::settings::ssldir
  }

  # the schema is now using a set parameter for the os or the default.
  $db_schema_mysql = "${share_dir}/icinga2-ido-mysql/schema/mysql.sql"
  $db_schema_pgsql = "${share_dir}/icinga2-ido-pgsql/schema/pgsql.sql"

}
