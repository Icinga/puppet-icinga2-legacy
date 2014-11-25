# == Defined type: icinga2::object::sysloglogger
#
#  This is a defined type for Icinga 2 user objects.
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/configuring-icinga2#objecttype-sysloglogger
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::sysloglogger (
  $object_name = $name,
  $severity = 'warning',
  $target_dir = '/etc/icinga2/objects',
  $target_file_name = "${name}.conf",
  $target_file_ensure = file,
  $target_file_owner = 'root',
  $target_file_group = 'root',
  $target_file_mode = '0644'
) {

  #Do some validation of the class' parameters:
  validate_string($object_name)
  validate_string($severity)
  validate_string($target_dir)
  validate_string($target_file_name)
  validate_string($target_file_owner)
  validate_string($target_file_group)
  validate_string($target_file_mode)

  file {"${target_dir}/${target_file_name}":
    ensure  => $target_file_ensure,
    owner   => $target_file_owner,
    group   => $target_file_group,
    mode    => $target_file_mode,
    content => template('icinga2/object_sysloglogger.conf.erb'),
    notify  => Service['icinga2'],
  }

}
