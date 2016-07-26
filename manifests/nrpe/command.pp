# Define icinga2::nrpe::command
#
# This defined type creates NRPE command definitions on machines running NRPE.
#
# Parameters:
# * $command_name = What NRPE will know the command as; this defaults to the title of the resource
# * $use_sudo = whether to use sudo to execute the command
# * $nrpe_plugin_libdir = The directory where the NRPE plugins themselves live
# * $nrpe_plugin_name = The name of the plugin the command will run
# * $nrpe_plugin_args = The arguments to pass to the plugin. This may be optional,
#                       depending on the plugin and whether it expects any arguments or parameters

define icinga2::nrpe::command (
  $command_name       = $name,
  $use_sudo           = false,
  $sudo_user          = 'root',
  $sudoers_dir        = $icinga2::nrpe::params::sudoers_dir_path,
  $nrpe_plugin_libdir = $icinga2::nrpe::params::nrpe_plugin_libdir,
  $nrpe_plugin_name   = undef,
  $nrpe_plugin_args   = undef,
) {

  #Do some validation of the class' parameters:
  validate_string($command_name)
  validate_bool($use_sudo)
  validate_string($sudo_user)
  validate_string($sudoers_dir)
  validate_string($nrpe_plugin_libdir)
  validate_string($nrpe_plugin_name)
  validate_string($nrpe_plugin_args)

  # Filenames in sudoers.d may not contain dots
  $sudo_filename = regsubst($command_name, '\.', '', 'G')
  $sudoers_filepath = "${sudoers_dir}/50_nrpe-${sudo_filename}"

  file { "/etc/nagios/nrpe.d/${command_name}.cfg":
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('icinga2/nrpe_command.cfg.erb'),
    require => Package[$icinga2::nrpe::params::icinga2_client_packages],
    notify  => Service[$icinga2::nrpe::params::nrpe_daemon_name]
  }

  if ( $use_sudo ) {
    file { "${sudoers_filepath}":
      owner   => 'root',
      group   => 'root',
      mode    => '0440',
      content => template('icinga2/sudoers_command.erb'),
    }
  } else {
    file { "${sudoers_filepath}":
      # Remove files that might have been created
      ensure  => absent,
    }
  }
}
