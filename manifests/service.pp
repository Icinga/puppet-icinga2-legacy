# == Class: icinga2::service
#
# This class manages the Icinga 2 daemon.
#
class icinga2::service {

  if $::kernel != 'windows' {

    $config_stamp = '/var/lib/icinga2/.puppet-config-stamp'

    Exec {
      path => $::path,
      user => 'root',
    }

    exec { 'icinga2 config stamp':
      command     => "touch '${config_stamp}'",
      refreshonly => true,
    } ~>

    exec { 'icinga2 daemon config test':
      command => 'icinga2 daemon -C',
      onlyif  => "test ! -e '${::icinga2::pid_file}' || test '${config_stamp}' -nt '${::icinga2::pid_file}'",
    } ~>

    service { 'icinga2':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      restart    => $::icinga2::restart_cmd,
    }

  } else {

    $config_stamp = "${::icinga2::params::i2dirprefix}/var/lib/icinga2/puppet-config-stamp.txt"

    Exec {
      path => $::path,
    }

    exec { 'icinga2 config stamp':
      #command     => "copy /B '${config_stamp}'+,, '${config_stamp}'",
      command     => "New-Item -ItemType file '${config_stamp}' -Force",
      provider    => powershell,
      refreshonly => true,
    } ~>

    exec { 'icinga2 daemon config test':
      command  => "& '${::icinga2::params::i2dirprefix}/sbin/icinga2.exe' daemon -C",
      provider => powershell,
      onlyif   => "\$Reload = \$false; Try { \$ErrorActionPreference = \"Stop\"; \$service = get-service icinga2 | select Status; \$starttime = Get-Process -ProcessName icinga2 | select name,starttime | sort-object starttime | Select-Object -First 1 | select starttime; \$timestamp = Get-Item '${config_stamp}'; if (\$service.Status -ne \"Running\") {\$Reload = \$true; } elseif (\$timestamp.LastWriteTime -gt \$starttime) { \$Reload = \$true} } Catch { \$Reload = \$true }; \$host.SetShouldExit(\$Reload)";
    } ~>

    service { 'icinga2':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      restart    => $::icinga2::restart_cmd,
    }
  }
}


