# Class: icinga2::nrpe::config
#
# This subclass configures Icinga clients.
#
class icinga2::nrpe::config {
  require ::icinga2
  require ::icinga2::nrpe::install

  #The NRPE configuration base directory:
  file { $::icinga2::nrpe_config_basedir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  #The folder that will hold our command definition files:
  file { '/etc/nagios/nrpe.d':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    purge   => $::icinga2::nrpe::nrpe_purge_unmanaged,
    recurse => true,
  }

  file { '/etc/nrpe.d':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    purge   => $::icinga2::nrpe::nrpe_purge_unmanaged,
    recurse => true,
  }

  #File resource for /etc/nagios/nrpe.cfg
  file { '/etc/nagios/nrpe.cfg':
    ensure  => file,
    path    => '/etc/nagios/nrpe.cfg',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('icinga2/nrpe.cfg.erb'),
  }
}

