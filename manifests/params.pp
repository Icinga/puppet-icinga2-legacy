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

  # the schema is currently not OS specific
  $db_schema_mysql = '/usr/share/icinga2-ido-mysql/schema/mysql.sql'
  $db_schema_pgsql = '/usr/share/icinga2-ido-pgsql/schema/pgsql.sql'

  $pid_file = '/run/icinga2/icinga2.pid'

  ##################
  # Icinga 2 parameters by OS/release
  case $::operatingsystem {
    'CentOS', 'RedHat', 'Scientific': {

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
    #Fail if we're on any other OS:
    default: { fail("${::operatingsystem} is not supported!") }
  }
}
