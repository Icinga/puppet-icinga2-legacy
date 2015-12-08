# == Class: icinga2::install
#
# This class installs the Icinga 2 daemon and needed packages.
#
class icinga2::install {

  package { 'icinga2':
    ensure   => $::icinga2::package_ensure,
  }

  validate_bool($::icinga2::install_plugins)
  if $::icinga2::install_plugins == true {
    ensure_packages($::icinga2::plugin_packages)
  }
  validate_array($::icinga2::plugin_packages_extra)
  if count($::icinga2::plugin_packages_extra) > 0 {
    ensure_packages($::icinga2::plugin_packages_extra)
  }

  validate_bool($::icinga2::install_mailutils)
  if $::icinga2::install_mailutils == true {
    ensure_packages($::icinga2::params::mail_package)
  }

}
