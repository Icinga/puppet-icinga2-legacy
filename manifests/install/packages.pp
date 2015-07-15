#Install packages for Icinga 2:
class icinga2::install::packages inherits icinga2 {

  #Install the Icinga 2 package
  package {$icinga2_package:
    ensure   => installed,
    provider => $package_provider,
  }

  if $install_nagios_plugins == true {
    #Install the Nagios plugins packages:
    package {$nagios_plugin_packages:
      ensure          => installed,
      provider        => $package_provider,
      install_options => $nagios_plugin_package_install_options,
    }
  }

  if $install_mail_utils_package == true {
    #Install the package that has the 'mail' binary in it so we can send notifications:
    package {$mail_package:
      ensure          => installed,
      provider        => $package_provider,
      install_options => $nagios_plugin_package_install_options,
    }
  }

}


