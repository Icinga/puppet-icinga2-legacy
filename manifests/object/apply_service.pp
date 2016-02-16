# == Defined type: icinga2::object::apply_service
#
# This is a defined type for Icinga 2 apply objects that apply services to hosts.
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/object-types#objecttype-host
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/configuring-icinga2#apply
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::apply_service (
  $object_servicename = $name,
  $apply = 'to Host',
  $template_to_import = 'generic-service',
  $display_name = $name,
  $assign_where = undef,
  $ignore_where = undef,
  $command_endpoint = undef,
  $groups = [],
  $vars = {},
  $check_command = undef,
  $max_check_attempts = undef,
  $check_period = undef,
  $check_interval = undef,
  $retry_interval = undef,
  $enable_notifications = true,
  $enable_active_checks = undef,
  $enable_passive_checks = undef,
  $enable_event_handler = undef,
  $enable_flapping = undef,
  $enable_perfdata = undef,
  $event_command = undef,
  #flapping_threshold is defined as a percentage, eg. 10%, 50%, etc.
  $flapping_threshold = undef,
  $volatile = undef,
  $notes = undef,
  $notes_url = undef,
  $action_url = undef,
  $icon_image = undef,
  $icon_image_alt = undef,
  $target_dir         = '/etc/icinga2/objects/applys',
  $target_file_name   = "${name}.conf",
  $target_file_ensure = file,
  $target_file_owner  = 'root',
  $target_file_group  = '0',
  $target_file_mode   = '0644',
  $refresh_icinga2_service = true,
  $custom_prepend     = [],
  $custom_append      = [],
) {

  #Do some validation of the class' parameters:
  validate_string($object_servicename)
  validate_string($template_to_import)
  validate_array($groups)
  validate_hash($vars)
  validate_string($target_dir)
  validate_string($target_file_name)
  validate_string($target_file_owner)
  validate_string($target_file_group)
  validate_string($target_file_mode)
  validate_bool($refresh_icinga2_service)
  validate_array($custom_prepend)
  validate_array($custom_append)

  #If the refresh_icinga2_service parameter is set to true...
  if $refresh_icinga2_service == true {
    $_notify = Class['::icinga2::service']
  }
  #...otherwise, use the same file resource but without a notify => parameter:
  else {
    $_notify = undef
  }

  file { "${target_dir}/${target_file_name}":
    ensure  => $target_file_ensure,
    owner   => $target_file_owner,
    group   => $target_file_group,
    mode    => $target_file_mode,
    content => template('icinga2/object_apply_service.conf.erb'),
    #...notify the Icinga 2 daemon so it can restart and pick up changes made to this config file...
    notify  => $_notify,
  }
}
