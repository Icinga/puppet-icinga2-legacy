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

  $config_template = 'icinga2/icinga2.conf.erb'
  $manage_service = true

  ##################
  # Icinga 2 common package parameters
  case $::operatingsystem {
    'CentOS', 'RedHat', 'Scientific': {
      #Pick the right package provider:
      $package_provider = 'yum'
    }

    'Ubuntu': {
      #Pick the right package provider:
      $package_provider = 'apt'
    }

    'Debian': {
      #Pick the right package provider:
      $package_provider = 'apt'
    }

    #Fail if we're on any other OS:
    default: { fail("${::operatingsystem} is not supported!") }
  }

  ##############################
  # Icinga 2 node parameters
  ##############################

  #Whether to manage the package repositories
  $manage_repos = true
  $use_debmon_repo = false

  #Whether to install the plugin packages when the icinga2::server class is applied:
  $install_nagios_plugins = true

  #whether to install packages that provide the 'mail' binary
  $install_mail_utils_package = false

  ##############################
  # Icinga 2 node package parameters

  #Pick the right package parameters based on the OS:
  case $::operatingsystem {
    #CentOS systems:
    'CentOS', 'RedHat', 'Scientific': {
      case $::operatingsystemmajrelease {
        '5': {
          #Icinga 2 package:
          $icinga2_package = 'icinga2'
          #Packages for Nagios plugins:
          $nagios_plugin_packages = ['nagios-plugins-nrpe', 'nagios-plugins-all', 'nagios-plugins-openmanage', 'nagios-plugins-check-updates']
          $mail_package = 'mailx'
          $nagios_plugin_package_install_options = undef
        }
        '6': {
          #Icinga 2 package:
          $icinga2_package = 'icinga2'
          #Packages for Nagios plugins:
          $nagios_plugin_packages = ['nagios-plugins-nrpe', 'nagios-plugins-all', 'nagios-plugins-openmanage', 'nagios-plugins-check-updates']
          #Package that provides a 'mail' binary:
          $mail_package = 'mailx'
          $nagios_plugin_package_install_options = undef
        }
        '7': {
          #Icinga 2 package:
          $icinga2_package = 'icinga2'
          #Packages for Nagios plugins:
          $nagios_plugin_packages = ['nagios-plugins-nrpe', 'nagios-plugins-all', 'nagios-plugins-openmanage', 'nagios-plugins-check-updates']
          #Package that provides a 'mail' binary:
          $mail_package = 'mailx'
          $nagios_plugin_package_install_options = undef
        }
        #Fail if we're on any other CentOS release:
        default: { fail("${::operatingsystemmajrelease} is not a supported CentOS release!") }
      }
    }

    'Ubuntu': {
      case $::operatingsystemrelease {
        #Ubuntu 12.04 doesn't have nagios-plugins-common or nagios-plugins-contrib packages available...
        '12.04': {
          #Icinga 2 package:
          $icinga2_package = 'icinga2'
          #Packages for Nagios plugins:
          $nagios_plugin_packages = ['nagios-plugins', 'nagios-plugins-basic', 'nagios-plugins-standard', 'nagios-snmp-plugins', 'nagios-plugins-extra', 'nagios-nrpe-plugin']
          #Package that provides a 'mail' binary:
          $mail_package = 'mailutils'
          #Specify '--no-install-recommends' so we don't inadvertently get Nagios 3 installed; it comes as a recommended package with most of the plugin packages:
          $nagios_plugin_package_install_options = '--no-install-recommends'
        }
        #...but 14.04 does:
        '14.04': {
          #Icinga 2 package:
          $icinga2_package = 'icinga2'
          $nagios_plugin_packages = [ 'nagios-plugins', 'nagios-plugins-basic', 'nagios-plugins-common', 'nagios-plugins-standard', 'nagios-snmp-plugins', 'nagios-plugins-extra', 'nagios-plugins-contrib', 'nagios-nrpe-plugin']
          #Package that provides a 'mail' binary:
          $mail_package = 'mailutils'
          #Specify '--no-install-recommends' so we don't inadvertently get Nagios 3 installed; it comes as a recommended package with most of the plugin packages:
          $nagios_plugin_package_install_options = '--no-install-recommends'
        }
        #Fail if we're on any other Ubuntu release:
        default: { fail("${::operatingsystemmajrelease} is not a supported Ubuntu release version!") }
      }
    }

    #Debian systems:
    'Debian': {
      case $::operatingsystemmajrelease {
        '7': {
          #Icinga 2 package:
          $icinga2_package = 'icinga2'
          #Packages for Nagios plugins:
          $nagios_plugin_packages = ['nagios-plugins', 'nagios-plugins-basic', 'nagios-plugins-standard', 'nagios-snmp-plugins', 'nagios-plugins-contrib', 'nagios-nrpe-plugin']
          #Package that provides a 'mail' binary:
          $mail_package = 'mailutils'
          #Specify '--no-install-recommends' so we don't inadvertently get Nagios 3 installed; it comes as a recommended package with most of the plugin packages:
          $nagios_plugin_package_install_options = '--no-install-recommends'
        }
        '8': {
          #Icinga 2 package:
          $icinga2_package = 'icinga2'
          #Packages for Nagios plugins:
          $nagios_plugin_packages = ['nagios-plugins', 'nagios-plugins-basic', 'nagios-plugins-standard', 'nagios-snmp-plugins', 'nagios-plugins-contrib', 'nagios-nrpe-plugin']
          #Package that provides a 'mail' binary:
          $mail_package = 'mailutils'
          #Specify '--no-install-recommends' so we don't inadvertently get Nagios 3 installed; it comes as a recommended package with most of the plugin packages:
          $nagios_plugin_package_install_options = '--no-install-recommends'
        }
        #Fail if we're on any other Debian release:
        default: { fail("${::operatingsystemmajrelease} is not a supported Debian release version!") }
      }
    }

    #Fail if we're on any other OS:
    default: { fail("${::operatingsystem} is not supported!") }
  }

  ##################
  # Icinga 2 node service settings

  case $::operatingsystem {
    #Icinga 2 server daemon names for Red Had/CentOS systems:
    'CentOS', 'RedHat', 'Scientific': {
      case $::operatingsystemmajrelease {
        '5': {
          $icinga2_daemon_name = 'icinga2'
        }
        '6': {
          $icinga2_daemon_name = 'icinga2'
        }
        '7': {
          $icinga2_daemon_name = 'icinga2'
        }
        #Fail if we're on any other CentOS release:
        default: { fail("${::operatingsystemmajrelease} is not a supported CentOS release!") }
      }
    }

    #Icinga 2 server daemon names for Ubuntu systems:
    'Ubuntu': {
      case $::operatingsystemrelease {
        '12.04': {
          $icinga2_daemon_name = 'icinga2'
        }
        '14.04': {
          $icinga2_daemon_name = 'icinga2'
        }
        #Fail if we're on any other Ubuntu release:
        default: { fail("${::operatingsystemrelease} is not a supported Ubuntu release version!") }
      }
    }

    #Icinga 2 server daemon names for Debian systems:
    'Debian': {
      case $::operatingsystemmajrelease {
        '7': {
          $icinga2_daemon_name = 'icinga2'
        }
        '8': {
          $icinga2_daemon_name = 'icinga2'
        }
        #Fail if we're on any other Debian release:
        default: { fail("${::operatingsystemmajrelease} is not a supported Debian release version!") }
      }
    }

    #Fail if we're on any other OS:
    default: { fail("${::operatingsystem} is not supported!") }
  }

  ##############################
  # Icinga 2 server parameters
  ##############################

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
  # Icinga 2 server package parameters

  #Pick the right package parameters based on the OS:
  case $::operatingsystem {
    #CentOS systems:
    'CentOS', 'RedHat', 'Scientific': {
      case $::operatingsystemmajrelease {
        '5': {
          #Icinga 2 server package
          $icinga2_server_package = 'icinga2'
          $icinga2_server_plugin_packages = ['nagios-plugins-nrpe', 'nagios-plugins-all', 'nagios-plugins-openmanage', 'nagios-plugins-check-updates']
          $icinga2_server_mail_package = 'mailx'
        }
        '6': {
          #Icinga 2 server package
          $icinga2_server_package = 'icinga2'
          $icinga2_server_plugin_packages = ['nagios-plugins-nrpe', 'nagios-plugins-all', 'nagios-plugins-openmanage', 'nagios-plugins-check-updates']
          $icinga2_server_mail_package = 'mailx'
        }
        '7': {
          #Icinga 2 server package
          $icinga2_server_package = 'icinga2'
          $icinga2_server_plugin_packages = ['nagios-plugins-nrpe', 'nagios-plugins-all', 'nagios-plugins-openmanage', 'nagios-plugins-check-updates']
          $icinga2_server_mail_package = 'mailx'
        }
        #Fail if we're on any other CentOS release:
        default: { fail("${::operatingsystemmajrelease} is not a supported CentOS release!") }
      }
    }

    #Ubuntu systems:
    'Ubuntu': {
      case $::operatingsystemrelease {
        #Ubuntu 12.04 doesn't have nagios-plugins-common or nagios-plugins-contrib packages available...
        '12.04': {
          $icinga2_server_package = 'icinga2'
          $icinga2_server_plugin_packages = ['nagios-plugins', 'nagios-plugins-basic', 'nagios-plugins-standard', 'nagios-snmp-plugins', 'nagios-plugins-extra', 'nagios-nrpe-plugin']
          $icinga2_server_mail_package = 'mailutils'
          #Specify '--no-install-recommends' so we don't inadvertently get Nagios 3 installed; it comes as a recommended package with most of the plugin packages:
          $server_plugin_package_install_options = '--no-install-recommends'
        }
        #...but 14.04 does:
        '14.04': {
          $icinga2_server_package = 'icinga2'
          $icinga2_server_plugin_packages = [ 'nagios-plugins', 'nagios-plugins-basic', 'nagios-plugins-common', 'nagios-plugins-standard', 'nagios-snmp-plugins', 'nagios-plugins-extra', 'nagios-plugins-contrib', 'nagios-nrpe-plugin']
          $icinga2_server_mail_package = 'mailutils'
          #Specify '--no-install-recommends' so we don't inadvertently get Nagios 3 installed; it comes as a recommended package with most of the plugin packages:
          $server_plugin_package_install_options = '--no-install-recommends'
        }
        #Fail if we're on any other Ubuntu release:
        default: { fail("${::operatingsystemmajrelease} is not a supported Ubuntu release version!") }
      }
    }

    #Debian systems:
    'Debian': {
      case $::operatingsystemmajrelease {
        '7': {
          $icinga2_server_package = 'icinga2'
          $icinga2_server_plugin_packages = ['nagios-plugins', 'nagios-plugins-basic', 'nagios-plugins-standard', 'nagios-snmp-plugins', 'nagios-plugins-contrib', 'nagios-nrpe-plugin']
          $icinga2_server_mail_package = 'mailutils'
          #Specify '--no-install-recommends' so we don't inadvertently get Nagios 3 installed; it comes as a recommended package with most of the plugin packages:
          $server_plugin_package_install_options = '--no-install-recommends'
        }
        '8': {
          $icinga2_server_package = 'icinga2'
          $icinga2_server_plugin_packages = ['nagios-plugins', 'nagios-plugins-basic', 'nagios-plugins-standard', 'nagios-snmp-plugins', 'nagios-plugins-contrib', 'nagios-nrpe-plugin']
          $icinga2_server_mail_package = 'mailutils'
          #Specify '--no-install-recommends' so we don't inadvertently get Nagios 3 installed; it comes as a recommended package with most of the plugin packages:
          $server_plugin_package_install_options = '--no-install-recommends'
        }
        #Fail if we're on any other Debian release:
        default: { fail("${::operatingsystemmajrelease} is not a supported Debian release version!") }
      }
    }

    #Fail if we're on any other OS:
    default: { fail("${::operatingsystem} is not supported!") }
  }

  ##############################
  # Icinga 2 server config parameters

  case $::operatingsystem {
    #CentOS or RedHat systems:
    'CentOS', 'RedHat', 'Scientific': {
      #Settings for /etc/icinga2/:
      $config_owner = 'icinga'
      $config_group = 'icinga'
      $config_mode  = '0640'
    }

    #Ubuntu and Debian systems:
    /(Ubuntu|Debian)/: {

      #Settings for /etc/icinga2/:
      $config_owner = 'nagios'
      $config_group = 'nagios'
      $config_mode  = '0640'
    }

    #Fail if we're on any other OS:
    default: { fail("${::operatingsystem} is not supported!") }
  }

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
  $allow_command_argument_processing = '0'

  # Whether or not to purge nrpe config files NOT managed by Puppet.
  $nrpe_purge_unmanaged = false

  case $::operatingsystem {
    #File and template variable names for Red Had/CentOS systems:
    'CentOS', 'RedHat', 'Scientific': {
      $nrpe_config_basedir = '/etc/nagios'
      $nrpe_plugin_libdir  = '/usr/lib64/nagios/plugins'
      $checkplugin_libdir  = '/usr/lib64/nagios/plugins'
      $nrpe_pid_file_path  = '/var/run/nrpe/nrpe.pid'
      $nrpe_user           = 'nrpe'
      $nrpe_group          = 'nrpe'
    }

    #File and template variable names for Ubuntu systems:
    'Ubuntu': {
      $nrpe_config_basedir  = '/etc/nagios'
      $nrpe_plugin_libdir   = '/usr/lib/nagios/plugins'
      $checkplugin_libdir   = '/usr/lib/nagios/plugins'
      $nrpe_pid_file_path   = '/var/run/nagios/nrpe.pid'
      $nrpe_user            = 'nagios'
      $nrpe_group           = 'nagios'
    }

    #File and template variable names for Ubuntu systems:
    'Debian': {
      $nrpe_config_basedir  = '/etc/nagios'
      $nrpe_plugin_libdir   = '/usr/lib/nagios/plugins'
      $checkplugin_libdir   = '/usr/lib/nagios/plugins'
      $nrpe_pid_file_path   = '/var/run/nagios/nrpe.pid'
      $nrpe_user            = 'nagios'
      $nrpe_group           = 'nagios'
    }

    #Fail if we're on any other OS:
    default: { fail("${::operatingsystem} is not supported!") }
  }

  ##################
  # Icinga 2 client package parameters
  case $::operatingsystem {
    #CentOS or RedHat systems:
    'CentOS', 'RedHat', 'Scientific': {
      case $::operatingsystemmajrelease {
        '5': {
          #Pick the right list of client packages:
          $icinga2_client_packages = ['nrpe', 'nagios-plugins-nrpe', 'nagios-plugins-all', 'nagios-plugins-openmanage', 'nagios-plugins-check-updates']
        }
        '6': {
          #Pick the right list of client packages:
          $icinga2_client_packages = ['nrpe', 'nagios-plugins-nrpe', 'nagios-plugins-all', 'nagios-plugins-openmanage', 'nagios-plugins-check-updates']
        }
        '7': {
          #Pick the right list of client packages:
          $icinga2_client_packages = ['nrpe', 'nagios-plugins-nrpe', 'nagios-plugins-all', 'nagios-plugins-openmanage', 'nagios-plugins-check-updates']
        }
        #Fail if we're on any other CentOS release:
        default: { fail("${::operatingsystemmajrelease} is not a supported CentOS release version!") }
      }

    }

    #Ubuntu systems:
    'Ubuntu': {
      case $::operatingsystemrelease {
        #Ubuntu 12.04 doesn't have nagios-plugins-common or nagios-plugins-contrib packages available...
        '12.04': {
          $icinga2_client_packages = ['nagios-nrpe-server', 'nagios-plugins', 'nagios-plugins-basic', 'nagios-plugins-standard', 'nagios-snmp-plugins', 'nagios-plugins-extra', 'nagios-nrpe-plugin']
          #Specify '--no-install-recommends' so we don't inadvertently get Nagios 3 installed; it comes as a recommended package with most of the plugin packages:
          $client_plugin_package_install_options = '--no-install-recommends'
        }
        #...but 14.04 does:
        '14.04': {
          $icinga2_client_packages = ['nagios-nrpe-server', 'nagios-plugins', 'nagios-plugins-basic', 'nagios-plugins-common', 'nagios-plugins-standard', 'nagios-snmp-plugins', 'nagios-plugins-extra', 'nagios-plugins-contrib', 'nagios-nrpe-plugin']
          #Specify '--no-install-recommends' so we don't inadvertently get Nagios 3 installed; it comes as a recommended package with most of the plugin packages:
          $client_plugin_package_install_options = '--no-install-recommends'
        }
        #Fail if we're on any other Ubuntu release:
        default: { fail("${::operatingsystemmajrelease} is not a supported Ubuntu release version!") }
      }
    }

    #Debian systems:
    'Debian': {
      case $::operatingsystemmajrelease {
        '7': {
          $icinga2_client_packages = ['nagios-nrpe-server', 'nagios-plugins', 'nagios-plugins-basic', 'nagios-plugins-standard', 'nagios-snmp-plugins', 'nagios-plugins-contrib', 'nagios-nrpe-plugin']
          #Specify '--no-install-recommends' so we don't inadvertently get Nagios 3 installed; it comes as a recommended package with most of the plugin packages:
          $client_plugin_package_install_options = '--no-install-recommends'
        }
        '8': {
          $icinga2_client_packages = ['nagios-nrpe-server', 'nagios-plugins', 'nagios-plugins-basic', 'nagios-plugins-standard', 'nagios-snmp-plugins', 'nagios-plugins-contrib', 'nagios-nrpe-plugin']
          #Specify '--no-install-recommends' so we don't inadvertently get Nagios 3 installed; it comes as a recommended package with most of the plugin packages:
          $client_plugin_package_install_options = '--no-install-recommends'
        }
        #Fail if we're on any other Debian release:
        default: { fail("${::operatingsystemmajrelease} is not a supported Debian release version!") }
      }
    }

    #Fail if we're on any other OS:
    default: { fail("${::operatingsystem} is not supported!") }
  }

  ##################
  # Icinga 2 client service parameters
  case $::operatingsystem {
    #Daemon names for Red Had/CentOS systems:
    'CentOS', 'RedHat', 'Scientific': {
      $nrpe_daemon_name = 'nrpe'
    }

    #Daemon names for Ubuntu systems:
    'Ubuntu': {
      $nrpe_daemon_name     = 'nagios-nrpe-server'
    }

    #Daemon names for Debian systems:
    'Debian': {
      $nrpe_daemon_name     = 'nagios-nrpe-server'
    }

    #Fail if we're on any other OS:
    default: { fail("${::operatingsystem} is not supported!") }
  }
}

