# == Class: icinga2::feature::ido_mysql
#
# Manage and enable the IdoMySqlConnection of Icinga2
#
# Also see the defined type icinga2::object::idomysqlconnection we are using.
#
class icinga2::feature::ido_mysql (
  $host                 = $::icinga2::db_host,
  $port                 = $::icinga2::db_port,
  $user                 = $::icinga2::db_user,
  $password             = $::icinga2::db_pass,
  $database             = $::icinga2::db_name,
  $table_prefix         = 'icinga_',
  $instance_name        = 'default',
  $instance_description = undef,
  $enable_ha            = true,
  $cleanup              = {
    acknowledgements_age           => 0,
    commenthistory_age             => 0,
    contactnotifications_age       => 0,
    contactnotificationmethods_age => 0,
    downtimehistory_age            => 0,
    eventhandlers_age              => 0,
    externalcommands_age           => 0,
    flappinghistory_age            => 0,
    hostchecks_age                 => 0,
    logentries_age                 => 0,
    notifications_age              => 0,
    processevents_age              => 0,
    statehistory_age               => 0,
    servicechecks_age              => 0,
    systemcommands_age             => 0,
  },
  $categories           = [],
) {

  package { 'icinga2-ido-mysql':
    ensure   => $::icinga2::package_ensure,
  }

  ::icinga2::object::idomysqlconnection { 'ido-mysql':
    host                 => $host,
    port                 => $port,
    user                 => $user,
    password             => $password,
    database             => $database,
    table_prefix         => $table_prefix,
    instance_name        => $instance_name,
    instance_description => $instance_description,
    enable_ha            => $enable_ha,
    cleanup              => $cleanup,
    categories           => $categories,
    target_file_name     => 'ido-mysql.conf',
    target_dir           => '/etc/icinga2/features-available',
  } ->

  ::icinga2::feature { 'ido-mysql':
    manage_file => false,
  }
}
