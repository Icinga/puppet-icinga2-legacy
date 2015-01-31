# == Class: icinga2::server::config
#
# This class configures the server components for the Icinga 2 monitoring system.
#
# === Parameters
#
# Coming soon...
#
# === Examples
#
# Coming soon...
#

class icinga2::server::config inherits icinga2::server {

  include icinga2::params

  if $purge_unmanaged_object_files == true {
    $recurse_objects = true
    $purge_objects = true
    $force_purge = true
  }
  else {
    $recurse_objects = false
    $purge_objects = false
    $force_purge = true
  }
  

  #Directory resource for /etc/icinga2/:
  file { '/etc/icinga2/':
    ensure => directory,
    path   => '/etc/icinga2/',
    owner  => $etc_icinga2_owner,
    group  => $etc_icinga2_group,
    mode   => $etc_icinga2_mode,
    #require => Package[$icinga2::params::icinga2_server_packages],
  }

  #File resource for /etc/icinga2/icinga2.conf:
  file { '/etc/icinga2/icinga2.conf':
    ensure  => file,
    path   => '/etc/icinga2/icinga2.conf',
    owner   => $etc_icinga2_icinga2_conf_owner,
    group   => $etc_icinga2_icinga2_conf_group,
    mode    => $etc_icinga2_icinga2_conf_mode,
    content => template('icinga2/icinga2.conf.erb'),
  }

  #Directory resource for /etc/icinga2/conf.d/:
  file { '/etc/icinga2/conf.d/':
    ensure => directory,
    path   => '/etc/icinga2/conf.d/',
    owner  => $etc_icinga2_confd_owner,
    group  => $etc_icinga2_confd_group,
    mode   => $etc_icinga2_confd_mode,
  }

  #Directory resource for /etc/icinga2/features-available/:
  file { '/etc/icinga2/features-available/':
    ensure => directory,
    path   => '/etc/icinga2/features-available/',
    owner  => $etc_icinga2_features_available_owner,
    group  => $etc_icinga2_features_available_group,
    mode   => $etc_icinga2_features_available_mode,
  }

  #Directory resource for /etc/icinga2/features-enabled/:
  file { '/etc/icinga2/features-enabled/':
    ensure => directory,
    path   => '/etc/icinga2/features-enabled/',
    owner  => $etc_icinga2_features_enabled_owner,
    group  => $etc_icinga2_features_enabled_group,
    mode   => $etc_icinga2_features_enabled_mode,
  }

  #Directory resource for /etc/icinga2/pki/:
  file { '/etc/icinga2/pki/':
    ensure => directory,
    path   => '/etc/icinga2/pki/',
    owner  => $etc_icinga2_pki_owner,
    group  => $etc_icinga2_pki_group,
    mode   => $etc_icinga2_pki_mode,
  }

  #Directory resource for /etc/icinga2/scripts/:
  file { '/etc/icinga2/scripts/':
    ensure => directory,
    path   => '/etc/icinga2/scripts/',
    owner  => $etc_icinga2_scripts_owner,
    group  => $etc_icinga2_scripts_group,
    mode   => $etc_icinga2_scripts_mode,
  }

  #Directory resource for /etc/icinga2/zones.d/:
  file { '/etc/icinga2/zones.d/':
    ensure => directory,
    path   => '/etc/icinga2/zones.d/',
    owner  => $etc_icinga2_zonesd_owner,
    group  => $etc_icinga2_zonesd_group,
    mode   => $etc_icinga2_zonesd_mode,
  }

  #File and directory resources for the object directories that can be used to hold different
  #types of configuration objects

  #Directory resource for /etc/icinga2/objects/:
  file { '/etc/icinga2/objects/':
    ensure  => directory,
    path    => '/etc/icinga2/objects/',
    owner   => $etc_icinga2_obejcts_owner,
    group   => $etc_icinga2_obejcts_group,
    mode    => $etc_icinga2_obejcts_mode,
    recurse => $recurse_objects,
    purge   => $purge_objects,
    force   => $force_purge
  }

  # Defining a list of subdirectories to be managed
  $managed_subdirectories = [
    '/etc/icinga2/objects/apilisteners/',
    '/etc/icinga2/objects/applys/',
    '/etc/icinga2/objects/checkcommands/',
    '/etc/icinga2/objects/checkercomponents/',
    '/etc/icinga2/objects/checkresultreaders/',
    '/etc/icinga2/objects/compatloggers/',
    '/etc/icinga2/objects/constants/',
    '/etc/icinga2/objects/dependencies/',
    '/etc/icinga2/objects/endpoints/',
    '/etc/icinga2/objects/eventcommands/',
    '/etc/icinga2/objects/externalcommandlisteners/',
    '/etc/icinga2/objects/fileloggers/',
    '/etc/icinga2/objects/graphitewriters/',
    '/etc/icinga2/objects/hostgroups/',
    '/etc/icinga2/objects/hosts/',
    '/etc/icinga2/objects/icingastatuswriters/',
    '/etc/icinga2/objects/idomysqlconnections/',
    '/etc/icinga2/objects/idopgsqlconnections/',
    '/etc/icinga2/objects/livestatuslisteners/',
    '/etc/icinga2/objects/notificationcommands/',
    '/etc/icinga2/objects/notificationcomponents/',
    '/etc/icinga2/objects/notifications/',
    '/etc/icinga2/objects/perfdatawriters/',
    '/etc/icinga2/objects/scheduleddowntimes/',
    '/etc/icinga2/objects/servicegroups/',
    '/etc/icinga2/objects/services/',
    '/etc/icinga2/objects/statusdatawriters/',
    '/etc/icinga2/objects/syslogloggers/',
    '/etc/icinga2/objects/templates/',
    '/etc/icinga2/objects/timeperiods/',
    '/etc/icinga2/objects/usergroups/',
    '/etc/icinga2/objects/users/',
    '/etc/icinga2/objects/zones/'
  ]

  # Managing all the subdirectories in the same way
  file { $managed_subdirectories:
    ensure  => directory,
    owner   => $etc_icinga2_obejcts_sub_dir_owner,
    group   => $etc_icinga2_obejcts_sub_dir_group,
    mode    => $etc_icinga2_obejcts_sub_dir_mode,
    recurse => $recurse_objects,
    purge   => $purge_objects,
    force   => $force_purge
  }

}
