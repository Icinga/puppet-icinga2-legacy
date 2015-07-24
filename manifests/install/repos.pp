# Setup repositories for Icinga
# lint:ignore:autoloader_layout lint:ignore:variable_scope
class icinga2::install::repos {
  if $::icinga2::manage_repos == true {
    case $::operatingsystem {
      #CentOS or RedHat systems:
      'CentOS', 'RedHat', 'Scientific': {
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
        if $::icinga2::use_debmon_repo == true {
          apt::source { 'debmon':
            location    => 'http://debmon.org/debmon',
            release     => "debmon-${::lsbdistcodename}",
            repos       => 'main',
            key         => '7E55BD75930BB3674BFD6582DC0EE15A29D662D2',
            key_source  => 'http://debmon.org/debmon/repo.key',
            include_src => false
          }
          if $::operatingsystemmajrelease == '7' {
            apt::pin { 'debmon':
              # backports repo use 200
              priority => '300',
              origin   => 'debmon.org'
            }
          }
        }
        elsif $::operatingsystemmajrelease == '7' {
          include apt::backports
        }
      }

      #Fail if we're on any other OS:
      default: { fail("${::operatingsystem} is not supported!") }
    }
  }
}

