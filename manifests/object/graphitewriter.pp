# == Defined type: icinga2::object::graphitewriter
#
#  This is a defined type for Icinga 2 GraphiteWriter objects.
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/configuring-icinga2#objecttype-graphitewriter
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::graphitewriter (
  $graphite_host        = '127.0.0.1',
  $graphite_port        = 2003,
  #Put the object files this defined type generates in features-available
  #since the Graphite writer feature is one that has to be explicitly enabled.
  $target_dir           = '/etc/icinga2/features-available',
  $target_file_name     = "${name}.conf",
  $target_file_owner    = 'root',
  $target_file_group    = 'root',
  $target_file_mode     = '0644'
) {

  #Do some validation
  validate_string($host)

  file {"${target_dir}/${target_file_name}":
    ensure => file,
    owner   => $target_file_owner,
    group   => $target_file_group,
    mode    => $target_file_mode,
    content => template('icinga2/object_graphitewriter.conf.erb'),
    notify  => Service['icinga2'],
  }
}
