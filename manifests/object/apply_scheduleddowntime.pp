# == Defined type: icinga2::object::apply_scheduleddowntime
#
# This is a defined type for Icinga 2 apply objects that apply downtimes to hosts or services.
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/configuring-icinga2#objecttype-scheduleddowntime
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/configuring-icinga2#apply
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::apply_scheduleddowntime (
  $object_downtimename = $name,
  $apply              = 'to Service',
  $template_to_import = undef,
  $assign_where       = undef,
  $ignore_where       = undef,
  $author             = undef,
  $comment            = undef,
  $fixed              = true,
  $duration           = undef,
  $ranges             = {},
  $target_dir         = '/etc/icinga2/objects/applys_scheduleddowntimes',
  $target_file_name   = "${name}.conf",
  $target_file_ensure = file,
  $target_file_owner  = 'root',
  $target_file_group  = 'root',
  $target_file_mode   = '0644',
  $refresh_icinga2_service = true
) {

  #Do some validation of the class' parameters:
  validate_string($object_downtimename)
  validate_string($template_to_import)
  validate_string($author)
  validate_string($comment)
  validate_bool($fixed)
  validate_string($duration)
  validate_hash($ranges)
  validate_string($target_dir)
  validate_string($target_file_name)
  validate_string($target_file_owner)
  validate_string($target_file_group)
  validate_string($target_file_mode)
  validate_bool($refresh_icinga2_service)

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
    content => template('icinga2/object_apply_scheduleddowntime.conf.erb'),
    #...notify the Icinga 2 daemon so it can restart and pick up changes made to this config file...
    notify  => $_notify,
  }
}
