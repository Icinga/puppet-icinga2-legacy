# Install packages for Icinga 2:
#
class icinga2::install::packages {
  # Install the Icinga 2 package
#  package { $::icinga2::icinga2_package:
#    ensure   => installed,
#    provider => $::icinga2::package_provider,
#  }

#  if $::icinga2::install_nagios_plugins == true {
#    # Install the Nagios plugins packages:
#    package { $::icinga2::nagios_plugin_packages:
#      ensure          => installed,
#      provider        => $::icinga2::package_provider,
#      install_options => $::icinga2::nagios_plugin_package_install_options,
#    }
#  }

#  if $::icinga2::install_mail_utils_package == true {
#    # Install the package that has the 'mail' binary in it
#    # so we can send notifications:
#    package { $::icinga2::mail_package:
#      ensure          => installed,
#      provider        => $::icinga2::package_provider,
#      install_options => $::icinga2::nagios_plugin_package_install_options,
#    }
#  }
}

