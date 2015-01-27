# == Class: icinga2::repo
#
# Setup software repositories for the host
#
class icinga2::repo(
  $use_debmon_repo = $icinga2::params::use_debmon_repo,
) inherits icinga2::params {

  validate_bool($use_debmon_repo)

  if $use_debmon_repo == true and $::operatingsystem != 'Debian' {
    warning('Debmon is only available for Debian, $use_debmon_repo has no effect!')
  }

  case $::operatingsystem {
    'CentOS', 'RedHat': {

      #Add the official Icinga Yum repository: http://packages.icinga.org/epel/
      # TODO: cleaner repo name? - it should be just "icinga" - purge the old name
      yumrepo { 'icinga2_yum_repo':
        baseurl  => "http://packages.icinga.org/epel/${::operatingsystemmajrelease}/release/",
        descr    => 'Icinga release repository',
        enabled  => 1,
        gpgcheck => 1,
        gpgkey   => 'http://packages.icinga.org/icinga.key'
      }
    }

    'Ubuntu': {
      #Include the apt module's base class so we can...
      include apt
      #...use the apt module to add the Icinga 2 PPA from launchpad.net:
      # https://launchpad.net/~formorer/+archive/ubuntu/icinga
      apt::ppa { 'ppa:formorer/icinga': }
    }

    'Debian': {
      include apt

      # TODO: handling for testing and unstable

      #On Debian (7) icinga2 packages are on backports
      if $use_debmon_repo == false {
        include apt::backports
      } else {
        apt::source { 'debmon':
          location    => 'http://debmon.org/debmon',
          release     => "debmon-${::lsbdistcodename}",
          repos       => 'main',
          key_source  => 'http://debmon.org/debmon/repo.key',
          key         => '29D662D2',
          include_src => false,
          # backports repo use 200
          pin         => '300'
        }
      }
    }

    #Fail if we're on any other OS:
    default: { fail("${::operatingsystem} is not supported for repository management!") }
  }
}
