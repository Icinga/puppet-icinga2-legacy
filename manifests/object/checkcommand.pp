# == Defined type: icinga2::object::checkcommand
#
# This is a defined type for Icinga 2 apply objects that create check commands
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/object-types#objecttype-checkcommand
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::checkcommand (
  $command,
  $object_checkcommandname               = $name,
  $arguments                             = {},
  $checkcommand_file_distribution_method = 'content',
  $checkcommand_source_file              = undef,
  $checkcommand_template                 = 'object/checkcommand.conf.erb',
  $checkcommand_template_module          = 'icinga2',
  $cmd_path                              = 'PluginDir',
  $env                                   = {},
  $refresh_icinga2_service               = true,
  $sudo                                  = false,
  $sudo_cmd                              = '/usr/bin/sudo',
  $target_dir                            = '/etc/icinga2/objects/checkcommands',
  $target_file_ensure                    = file,
  $target_file_group                     = $::icinga2::config_group,
  $target_file_mode                      = $::icinga2::config_mode,
  $target_file_name                      = "${name}.conf",
  $target_file_owner                     = $::icinga2::config_owner,
  $templates                             = ['plugin-check-command'],
  $timeout                               = undef,
  $vars                                  = {},
  #$methods                               = undef, Need to get more details about this attribute
) {

  #Do some validation of the class parameters:
  validate_string($object_checkcommandname)
  validate_array($templates)
  if ! is_array($command) {
    validate_string($command)
  }
  if ! is_string($command) {
    validate_array($command)
  }
  validate_string($cmd_path)
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
    if $checkcommand_file_distribution_method == 'content' {
      file {"${target_dir}/${target_file_name}":
        ensure  => $target_file_ensure,
        owner   => $target_file_owner,
        group   => $target_file_group,
        mode    => $target_file_mode,
        content => template("${checkcommand_template_module}/${checkcommand_template}"),
        notify  => Class['::icinga2::service'],
      }
    }
    elsif $checkcommand_file_distribution_method == 'source' {
      file {"${target_dir}/${target_file_name}":
        ensure => $target_file_ensure,
        owner  => $target_file_owner,
        group  => $target_file_group,
        mode   => $target_file_mode,
        source => $checkcommand_source_file,
        notify => Class['::icinga2::service'],
      }
    }
    else {
      notify {'Missing/Incorrect File Distribution Method':
        message => 'The parameter checkcommand_file_distribution_method is missing or incorrect. Please set content or source',
      }
    }
  }

  #...otherwise, use the same file resource but without a notify => parameter:
  else {

    if $checkcommand_file_distribution_method == 'content' {
      file {"${target_dir}/${target_file_name}":
        ensure  => $target_file_ensure,
        owner   => $target_file_owner,
        group   => $target_file_group,
        mode    => $target_file_mode,
        content => template("${checkcommand_template_module}/${checkcommand_template}"),
      }
    }
    elsif $checkcommand_file_distribution_method == 'source' {
      file {"${target_dir}/${target_file_name}":
        ensure => $target_file_ensure,
        owner  => $target_file_owner,
        group  => $target_file_group,
        mode   => $target_file_mode,
        source => $checkcommand_source_file,
      }
    }
    else {
      notify {'Missing/Incorrect File Distribution Method':
        message => 'The parameter checkcommand_file_distribution_method is missing or incorrect. Please set content or source',
      }
    }

  }

}
