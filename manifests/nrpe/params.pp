class icinga2::nrpe::params (

) {

  ##################
  # Icinga 2 client service parameters
  case $::operatingsystem {
    #Daemon names for Red Had/CentOS systems:
    'CentOS', 'RedHat': {
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
  $nrpe_allowed_hosts      = ['127.0.0.1',]
  #Determines whether or not the NRPE daemon will allow clients to specify arguments to commands that are executed
  # *** ENABLING THIS OPTION IS A SECURITY RISK! ***
  # Defaults to NOT allow command arguments
  $allow_command_argument_processing = '0'

  # Whether or not to purge nrpe config files NOT managed by Puppet.
  $nrpe_purge_unmanaged = false

  case $::operatingsystem {
    #File and template variable names for Red Had/CentOS systems:
    'CentOS', 'RedHat': {
      $nrpe_config_basedir = '/etc/nagios'
      $nrpe_plugin_libdir  = '/usr/lib64/nagios/plugins'
      $checkplugin_libdir  = '/usr/lib64/nagios/plugins'
      $nrpe_pid_file_path  = '/var/run/nrpe/nrpe.pid'
      $sudo_file_path      = '/usr/bin/sudo'
      $sudoers_dir_path    = '/etc/sudoers.d'
      $nrpe_user           = 'nrpe'
      $nrpe_group          = 'nrpe'
    }

    #File and template variable names for Ubuntu systems:
    'Ubuntu': {
      $nrpe_config_basedir  = '/etc/nagios'
      $nrpe_plugin_libdir   = '/usr/lib/nagios/plugins'
      $checkplugin_libdir   = '/usr/lib/nagios/plugins'
      $nrpe_pid_file_path   = '/var/run/nagios/nrpe.pid'
      $sudo_file_path       = '/usr/bin/sudo'
      $sudoers_dir_path     = '/etc/sudoers.d'
      $nrpe_user            = 'nagios'
      $nrpe_group           = 'nagios'
    }

    #File and template variable names for Ubuntu systems:
    'Debian': {
      $nrpe_config_basedir  = '/etc/nagios'
      $nrpe_plugin_libdir   = '/usr/lib/nagios/plugins'
      $checkplugin_libdir   = '/usr/lib/nagios/plugins'
      $nrpe_pid_file_path   = '/var/run/nagios/nrpe.pid'
      $sudo_file_path       = '/usr/bin/sudo'
      $sudoers_dir_path     = '/etc/sudoers.d'
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
    'CentOS', 'RedHat': {
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
          $icinga2_client_packages = ['nagios-nrpe-server', 'nagios-snmp-plugins', 'nagios-nrpe-plugin']
          #Specify '--no-install-recommends' so we don't inadvertently get Nagios 3 installed; it comes as a recommended package with most of the plugin packages:
          $client_plugin_package_install_options = '--no-install-recommends'
        }
        #...but 14.04 does:
        '14.04': {
          $icinga2_client_packages = ['nagios-nrpe-server', 'nagios-plugins-common', 'nagios-plugins-extra', 'nagios-plugins-contrib', 'nagios-nrpe-plugin']
          #Specify '--no-install-recommends' so we don't inadvertently get Nagios 3 installed; it comes as a recommended package with most of the plugin packages:
          $client_plugin_package_install_options = '--no-install-recommends'
        }
        '16.04': {
          $icinga2_client_packages = ['nagios-nrpe-server', 'nagios-plugins-common', 'nagios-plugins-extra', 'nagios-plugins-contrib', 'nagios-nrpe-plugin']
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
        #Fail if we're on any other Debian release:
        default: { fail("${::operatingsystemmajrelease} is not a supported Debian release version!") }
      }
    }

    #Fail if we're on any other OS:
    default: { fail("${::operatingsystem} is not supported!") }
  }
}
