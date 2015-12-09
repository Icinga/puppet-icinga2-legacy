# = Define: icinga2::conf
#
# General Apache define to be used to create generic custom .conf files
# Very simple wrapper to a normal file type
# Use source or template to define the source
#
# == Parameters
#
# [*source*]
#   Sets the content of source parameter for the dotconf file
#   If defined, icinga2 dotconf file will have the param: source => $source
#
# [*template*]
#   Sets the path to the template to use as content for dotconf file
#   If defined, icinga2 dotconf file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#
# [*options_hash*]
#   Custom hash with key values to use in custom templates
#
define icinga2::conf (
  $source            = undef,
  $template          = undef,
  $options_hash      = undef,
  $ensure            = present,
  $target_dir        = '/etc/icinga2/conf.d',
  $target_file_name  = "${name}.conf",
  $target_file_owner = 'root',
  $target_file_group = 'root',
  $target_file_mode  = '0644',
) {

  validate_string($target_dir)
  validate_string($target_file_name)
  validate_string($target_file_owner)
  validate_string($target_file_group)
  validate_string($target_file_mode)

  $manage_file_source = $source

  if $template {
    $manage_file_content = template($template)
  }
  else {
    $manage_file_content = undef
  }

  file { "${target_dir}/${target_file_name}":
    ensure  => $ensure,
    owner   => $target_file_owner,
    group   => $target_file_group,
    mode    => $target_file_mode,
    notify  => Class['::icinga2::service'],
    source  => $manage_file_source,
    content => $manage_file_content,
  }

}

