# Setup repositories yum for Icinga
#
class icinga2::repo::apt {
  # Include the apt module's base class so we can use ppa and other sources
  include ::apt
  case $::operatingsystem {
    'Ubuntu' : {

      # use the apt module to add the Icinga 2 PPA from launchpad.net:
      # https://launchpad.net/~formorer/+archive/ubuntu/icinga
      apt::ppa { 'ppa:formorer/icinga': }
    }

    # Debian systems:
    'Debian' : {
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
      } elsif $::operatingsystemmajrelease == '7' {
        include apt::backports
      }
    }
    default: { fail("${::operatingsystem} is not supported!") }
  }
}
