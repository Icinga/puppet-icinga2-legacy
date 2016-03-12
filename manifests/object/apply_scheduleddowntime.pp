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
  $author,
  $comment,
  $assign_where,
  $ranges,
  $apply        = 'Service',
  $templates    = [],
  $ignore_where = undef,
  $fixed        = undef,
  $duration     = undef,
  $target_dir   = '/etc/icinga2/objects/applys',
  $file_name    = "${name}.conf",
) {

  validate_re($apply, '^(Host|Service)$', 'ScheduledDowntime must either apply to a Host or Service!')
  validate_array($templates)
  validate_string($author)
  validate_string($comment)
  if $fixed != undef {
    validate_bool($fixed)
  }
  validate_string($duration)
  validate_hash($ranges)

  validate_absolute_path($target_dir)
  validate_string($file_name)

  file { "icinga2 apply scheduleddowntime ${name}":
    ensure  => file,
    path    => "${target_dir}/${file_name}",
    owner   => $::icinga2::config_owner,
    group   => $::icinga2::config_group,
    mode    => $::icinga2::config_mode,
    content => template('icinga2/object/apply_scheduleddowntime.conf.erb'),
  }

  if $::icinga2::manage_service {
    File["icinga2 apply scheduleddowntime ${name}"] ~> Class['::icinga2::service']
  }

}
