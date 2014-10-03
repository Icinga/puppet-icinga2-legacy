# == Defined type: icinga2::object::checkcommand
#
#  This is a defined type for Icinga 2 CheckCommand objects
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/configuring-icinga2#objecttype-checkcommand

define icinga2::object::checkcommand (
  $checkcommand_name              = "${name}.conf",
  $checkcommand_target_dir        = '/etc/icinga2/objects/checkcommands',
  $checkcommand_target_file_owner = 'icinga',
  $checkcommand_target_file_group = 'icinga',
  $checkcommand_target_file_mode  = '0640',
  $checkcommand_source_file       = undef,
) {

  #Do some validation of the class' parameters:
  validate_string($checkcommand_target_dir)
  validate_string($checkcommand_name)
  validate_string($checkcommand_target_file_owner)
  validate_string($checkcommand_target_file_group)
  validate_string($checkcommand_target_file_mode)

  file { "${checkcommand_target_dir}/${checkcommand_name}":
    ensure => file,
    owner  => $checkcommand_target_file_owner,
    group  => $checkcommand_target_file_group,
    mode   => $checkcommand_target_file_mode,
    source => $checkcommand_source_file,
    notify => Service['icinga2'],
  }

}
