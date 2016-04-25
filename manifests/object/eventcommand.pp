# == Defined type: icinga2::object::eventcommand
#
# This is a defined type for Icinga 2 apply objects that create event commands
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/object-types#objecttype-eventcommand
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::eventcommand (
  $command,
  $object_eventcommandname = $name,
  $templates               = ['plugin-event-command'],
  #$methods                = undef Need to get more details about this attribute
  $cmd_path                = 'PluginDir',
  $arguments               = {},
  $env                     = {},
  $vars                    = {},
  $timeout                 = undef,
  $target_dir              = '/etc/icinga2/objects/eventcommands',
  $target_file_name        = "${name}.conf",
  $target_file_ensure      = file,
  $target_file_owner       = $::icinga2::config_owner,
  $target_file_group       = $::icinga2::config_group,
  $target_file_mode        = $::icinga2::config_mode,
  $refresh_icinga2_service = true
) {

  #Do some validation of the class' parameters:
  validate_string($object_eventcommandname)
  validate_array($templates)
  if ! is_string($command) {
    validate_array($command)
  }
  validate_string($cmd_path)
  validate_hash($arguments)
  validate_hash($env)
  validate_hash($vars)
  if $timeout {
    validate_re($timeout, '^\d+$')
  }
  validate_string($target_dir)
  validate_string($target_file_name)
  validate_string($target_file_owner)
  validate_string($target_file_group)
  validate_re($target_file_mode, '^\d{4}$')
  validate_bool($refresh_icinga2_service)

  #If the refresh_icinga2_service parameter is set to true...
  if $refresh_icinga2_service == true {

    file { "${target_dir}/${target_file_name}":
      ensure  => $target_file_ensure,
      owner   => $target_file_owner,
      group   => $target_file_group,
      mode    => $target_file_mode,
      content => template('icinga2/object/eventcommand.conf.erb'),
      #...notify the Icinga 2 daemon so it can restart and pick up changes made to this config file...
      notify  => Class['::icinga2::service'],
    }

  }
  #...otherwise, use the same file resource but without a notify => parameter:
  else {

    file { "${target_dir}/${target_file_name}":
      ensure  => $target_file_ensure,
      owner   => $target_file_owner,
      group   => $target_file_group,
      mode    => $target_file_mode,
      content => template('icinga2/object/eventcommand.conf.erb'),
    }

  }

}

