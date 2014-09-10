# == Class: icinga2::params
#
# This class contains config options and settings for use elsewhere in the module.
#
# === Parameters
#
# See the inline comments.
#

class icinga2::params {

  $sup_rhel_ = $::osfamily == 'RedHat' and $::operatingsystemrelease == '6.5'
  $sup_ubu = $::operatingsystem == 'Ubuntu' and (
    $::operatingsystemrelease == '12.04' or
    $::operatingsystemrelease == '14.04')

  if !($sup_rhel or $sup_ubu) {
    fail('Your platform ist not supported')
  }

  ##############################
  # Icinga 2 server parameters
  ##############################

  #Whether to manage the package repositories
  $manage_repos = true
  $server_db_type = 'pgsql'

  #Database paramters
  $db_name = 'icinga2_data'
  $db_user = 'icinga2'
  $db_password = 'password'
  $db_host = 'localhost'
  $db_port        = '5432'

 #Whether to install the plugin packages when the icinga2::server class is applied:
 $server_install_nagios_plugins = true

  ##############################
  # Icinga 2 server package parameters

  #Pick the right package parameters based on the OS:
  case $::osfamily {
    'RedHat': {
      #Icinga 2 server package
      $icinga2_server_package = 'icinga2'
      $icinga2_server_plugin_packages = ["nagios-plugins-nrpe", "nagios-plugins-all", "nagios-plugins-openmanage", "nagios-plugins-check-updates"]
    }
    'Debian': {
      $icinga2_server_package = 'icinga2'
      $icinga2_server_plugin_packages = ["nagios-snmp-plugins", "nagios-plugins-extra", "nagios-nrpe-plugin"]
    }
  }

  ##############################
  # Icinga 2 server config parameters

  case $::osfamily {
    'RedHat': {
      #Settings for /etc/icinga2/:
      $etc_icinga2_owner = 'icinga'
      $etc_icinga2_group = 'icinga'
      $etc_icinga2_mode  = '750'
      #Settings for /etc/icinga2/icinga2.conf:
      $etc_icinga2_icinga2_conf_owner = 'icinga'
      $etc_icinga2_icinga2_conf_group = 'icinga'
      $etc_icinga2_icinga2_conf_mode  = '640'
      #Settings for /etc/icinga2/conf.d/
      $etc_icinga2_confd_owner = 'icinga'
      $etc_icinga2_confd_group = 'icinga'
      $etc_icinga2_confd_mode  = '750'
      #Settings for /etc/icinga2/features-available/:
      $etc_icinga2_features_available_owner = 'icinga'
      $etc_icinga2_features_available_group = 'icinga'
      $etc_icinga2_features_available_mode  = '750'
      #Settings for /etc/icinga2/features-enabled/:
      $etc_icinga2_features_enabled_owner = 'icinga'
      $etc_icinga2_features_enabled_group = 'icinga'
      $etc_icinga2_features_enabled_mode  = '750'
      #Settings for /etc/icinga2/pki/:
      $etc_icinga2_pki_owner = 'icinga'
      $etc_icinga2_pki_group = 'icinga'
      $etc_icinga2_pki_mode  = '750'
      #Settings for /etc/icinga2/scripts/:
      $etc_icinga2_scripts_owner = 'icinga'
      $etc_icinga2_scripts_group = 'icinga'
      $etc_icinga2_scripts_mode  = '750'
      #Settings for /etc/icinga2/zones.d/:
      $etc_icinga2_zonesd_owner = 'icinga'
      $etc_icinga2_zonesd_group = 'icinga'
      $etc_icinga2_zonesd_mode  = '750'
      #Settings for /etc/icinga2/objects/:
      $etc_icinga2_obejcts_owner = 'icinga'
      $etc_icinga2_obejcts_group = 'icinga'
      $etc_icinga2_obejcts_mode  = '750'
      #Settings for subdirectories of /etc/icinga2/objects/:
      $etc_icinga2_obejcts_sub_dir_owner = 'icinga'
      $etc_icinga2_obejcts_sub_dir_group = 'icinga'
      $etc_icinga2_obejcts_sub_dir_mode  = '750'
    }

    'Debian': {
      #Settings for /etc/icinga2/:
      $etc_icinga2_owner = 'root'
      $etc_icinga2_group = 'root'
      $etc_icinga2_mode  = '755'
      #Settings for /etc/icinga2/icinga2.conf:
      $etc_icinga2_icinga2_conf_owner = 'root'
      $etc_icinga2_icinga2_conf_group = 'root'
      $etc_icinga2_icinga2_conf_mode  = '644'
      #Settings for /etc/icinga2/conf.d/
      $etc_icinga2_confd_owner = 'root'
      $etc_icinga2_confd_group = 'root'
      $etc_icinga2_confd_mode  = '755'
      #Settings for /etc/icinga2/features-available:
      $etc_icinga2_features_available_owner = 'root'
      $etc_icinga2_features_available_group = 'root'
      $etc_icinga2_features_available_mode  = '755'
      #Settings for /etc/icinga2/features-enabled:
      $etc_icinga2_features_enabled_owner = 'root'
      $etc_icinga2_features_enabled_group = 'root'
      $etc_icinga2_features_enabled_mode  = '755'
      #Settings for /etc/icinga2/pki/:
      $etc_icinga2_pki_owner = 'root'
      $etc_icinga2_pki_group = 'root'
      $etc_icinga2_pki_mode  = '755'
      #Settings for /etc/icinga2/scripts/:
      $etc_icinga2_scripts_owner = 'root'
      $etc_icinga2_scripts_group = 'root'
      $etc_icinga2_scripts_mode  = '755'
      #Settings for /etc/icinga2/zones.d/:
      $etc_icinga2_zonesd_owner = 'root'
      $etc_icinga2_zonesd_group = 'root'
      $etc_icinga2_zonesd_mode  = '755'
      #Settings for /etc/icinga2/objects/:
      $etc_icinga2_obejcts_owner = 'root'
      $etc_icinga2_obejcts_group = 'root'
      $etc_icinga2_obejcts_mode  = '755'
      #Settings for subdirectories of /etc/icinga2/objects/:
      $etc_icinga2_obejcts_sub_dir_owner = 'root'
      $etc_icinga2_obejcts_sub_dir_group = 'root'
      $etc_icinga2_obejcts_sub_dir_mode  = '755'
    }
  }

  ##################
  # Icinga 2 server service settings 

  $icinga2_server_service_name = 'icinga2'

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
  $nrpe_config_basedir = '/etc/nagios'
  $nrpe_pid_file_path = '/var/run/nagios/nrpe.pid'

  case $::osfamily {
    'RedHat': {
      $nrpe_plugin_libdir  = "/usr/lib64/nagios/plugins"
      $nrpe_user           = "nrpe"
      $nrpe_group          = "nrpe"
    }
    'Debian': {
      $nrpe_plugin_libdir   = "/usr/lib/nagios/plugins"
      $nrpe_user            = "nagios"
      $nrpe_group           = "nagios"
    }
  }

  ##################
  # Icinga 2 client package parameters
  case $::osfamily {
    'RedHat': {
      #Pick the right list of client packages:
      $icinga2_client_packages = ["nrpe", "nagios-plugins-nrpe", "nagios-plugins-all", "nagios-plugins-openmanage", "nagios-plugins-check-updates"]
    }
    'Debian': {
      $icinga2_client_packages = ["nagios-nrpe-server", "nagios-plugins-extra", "nagios-nrpe-plugin"]
    }
  }

  ##################
  # Icinga 2 client service parameters
  case $::osfamily {
    'RedHat': {
      $nrpe_daemon_name = 'nrpe'
    }
    'Debian': {
      $nrpe_daemon_name = 'nagios-nrpe-server'
    }
  }

}
