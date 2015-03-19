# == Class: icinga2::feature::command
#
# Manage and enable the default log of Icinga2
#
class icinga2::feature::command (
  $command_path = undef,
) {

  if $command_path {
    validate_absolute_path($command_path)
  }

  ::icinga2::feature { 'command':
    content => template('icinga2/feature/command.conf.erb'),
  }
}
