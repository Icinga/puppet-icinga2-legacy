# == Class: icinga2::feature::ido_pgsql
#
# Manage and enable the IdoPgSqlConnection of Icinga2
#
# Also see the defined type icinga2::object::idopgsqlconnection we are using.
#
class icinga2::feature::ido_pgsql (
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

  package { 'icinga2-ido-pgsql':
    ensure   => installed,
    provider => $::icinga2::package_provider,
  }

  ::icinga2::object::idopgsqlconnection { 'ido-pgsql':
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
    target_file_name     => 'ido-pgsql.conf',
    target_dir           => '/etc/icinga2/features-available',
  } ->

  ::icinga2::feature { 'ido-pgsql':
    manage_file => false,
  }
}
