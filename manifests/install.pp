# == Class: icinga2::install
#
# This class installs the Icinga 2 daemon.
#
# === Parameters
#
# Coming soon...
#
# === Examples
#
# Coming soon...
#

class icinga2::install inherits icinga2 {

  #Apply our classes in the right order. Use the squiggly arrows (~>) to ensure that the
  #class left is applied before the class on the right and that it also refreshes the
  #class on the right.

  #Here, we're setting up the package repos first, then installing the packages, then
  #running any execs that are needed to set things up further:
  class{'::icinga2::install::repos':} ~>
  class{'::icinga2::install::packages':} ~>
  class{'::icinga2::install::execs':} ->
  Class['icinga2::install']

}

# Setup repositories for Icinga
# lint:ignore:autoloader_layout lint:ignore:variable_scope
class icinga2::install::repos inherits icinga2 {

  if $manage_repos == true {
    case $::operatingsystem {
      #CentOS or RedHat systems:
      'CentOS', 'RedHat': {
        #Add the official Icinga Yum repository: http://packages.icinga.org/epel/
        yumrepo { 'icinga2_yum_repo':
          baseurl  => "http://packages.icinga.org/epel/${::operatingsystemmajrelease}/release/",
          descr    => 'Icinga 2 Yum repository',
          enabled  => 1,
          gpgcheck => 1,
          gpgkey   => 'http://packages.icinga.org/icinga.key',
        }
      }

      #Ubuntu systems:
      'Ubuntu': {
        #Include the apt module's base class so we can...
        include ::apt
        #...use the apt module to add the Icinga 2 PPA from launchpad.net:
        # https://launchpad.net/~formorer/+archive/ubuntu/icinga
        apt::ppa { 'ppa:formorer/icinga': }
      }

      #Debian systems:
      'Debian': {
        include ::apt

        #On Debian (7) icinga2 packages are on backports
        if $use_debmon_repo == false {
          include ::apt::backports
        } else {
          apt::source { 'debmon':
            location    => 'http://debmon.org/debmon',
            release     => "debmon-${lsbdistcodename}",
            repos       => 'main',
            key_source  => 'http://debmon.org/debmon/repo.key',
            key         => '7E55BD75930BB3674BFD6582DC0EE15A29D662D2',
            include_src => false,
            # backports repo use 200
            pin         => '300',
          }
        }
      }

      #Fail if we're on any other OS:
      default: { fail("${::operatingsystem} is not supported!") }
    }
  }

}

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

#This class contains exec resources
class icinga2::install::execs inherits icinga2 {

  #Exec resources for SSL setup will go here.

}
# lint:endignore
