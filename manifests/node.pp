# == Class: icinga2::node
#
# This module installs Icinga 2 and does some basic, general configuration that's applicable
# to all of the different types of roles Icinga 2 can be used in (server, agent, satellite, etc.)
#
# === Parameters
#
# Coming soon...
#
# === Examples
#
# Coming soon...
#

class icinga2::node ( 
  $manage_repos = $icinga2::params::manage_repos,
  $manage_service = $icinga2::params::manage_service,
  $use_debmon_repo = $icinga2::params::use_debmon_repo,
  $package_provider = $icinga2::params::package_provider,
  $icinga2_package = $icinga2::params::icinga2_package,
  $install_nagios_plugins = $icinga2::params::install_nagios_plugins,
  $install_mail_utils_package = $icinga2::params::install_mail_utils_package,
  $enabled_features = $icinga2::params::enabled_features,
  $disabled_features = $icinga2::params::disabled_features,
  $purge_unmanaged_object_files = $icinga2::params::purge_unmanaged_object_files

) inherits icinga2::params {

  #Do some validation of parameters so we know we have the right data types:
  validate_bool($manage_repos)
  validate_bool($use_debmon_repo)
  validate_string($package_provider)
  validate_string($icinga2_package)
  validate_bool($install_nagios_plugins)


  if $manage_service == true {
    #Apply our classes in the right order. Use the squiggly arrows (~>) to ensure that the
    #class left is applied before the class on the right and that it also refreshes the
    #class on the right.
    class {'icinga2::node::install':} ~>
    class {'icinga2::node::config':} ~>
    class {'icinga2::features':
      enabled_features  => $enabled_features,
      disabled_features => $disabled_features,
    } ~>
    class {'icinga2::node::service':}
    #Use the contain function so that the resources in 
    #the subclasses don't float off and get applied in a non-deterministic order. The
    #containment ensures that the ordering arrows above do what they're supposed to.
    #More info on Puppet Labs' docs:
    # https://docs.puppetlabs.com/puppet/3.7/reference/lang_containment.html#the-contain-function
    contain 'icinga2::node::install'
    contain 'icinga2::node::config'
    contain 'icinga2::features'
    contain 'icinga2::node::service'
    
  }
  else {
    #Apply our classes in the right order. Use the squiggly arrows (~>) to ensure that the
    #class left is applied before the class on the right and that it also refreshes the
    #class on the right.
    class {'icinga2::node::install':} ~>
    class {'icinga2::node::config':} ~>
    class {'icinga2::features':
      enabled_features  => $enabled_features,
      disabled_features => $disabled_features,
    }
    
    contain 'icinga2::node::install'
    contain 'icinga2::node::config'
    contain 'icinga2::features'

  }

}