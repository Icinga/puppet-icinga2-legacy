# == Class: icinga2::objects
#
# This class will search for icinga2 objects inside hiera's database and will create them.
# This class is called by icinga2
#
# === Parameters
#
# None. See inline comments for parameters on the individual object type manifests for
# more details.
#

class icinga2::objects {
  $hash_apply_dependency = hiera_hash('icinga2::object::apply_dependency',undef)
  if $hash_apply_dependency {
    create_resources(icinga2::object::apply_dependency,$hash_apply_dependency)
  }
  $hash_apply_notification_to_host = hiera_hash('icinga2::object::apply_notification_to_host',undef)
  if $hash_apply_notification_to_host {
    create_resources(icinga2::object::apply_notification_to_host,$hash_apply_notification_to_host)
  }
  $hash_apply_notification_to_service = hiera_hash('icinga2::object::apply_notification_to_service',undef)
  if $hash_apply_notification_to_service {
    create_resources(icinga2::object::apply_notification_to_service,$hash_apply_notification_to_service)
  }
  $hash_apply_service_to_host = hiera_hash('icinga2::object::apply_service_to_host',undef)
  if $hash_apply_service_to_host {
    create_resources(icinga2::object::apply_service_to_host,$hash_apply_service_to_host)
  }
  $hash_checkcommand = hiera_hash('icinga2::object::checkcommand',undef)
  if $hash_checkcommand {
    create_resources(icinga2::object::checkcommand,$hash_checkcommand)
  }
  $hash_dependency = hiera_hash('icinga2::object::dependency',undef)
  if $hash_dependency {
    create_resources(icinga2::object::dependency,$hash_dependency)
  }
  $hash_eventcommand = hiera_hash('icinga2::object::eventcommand',undef)
  if $hash_eventcommand {
    create_resources(icinga2::object::eventcommand,$hash_eventcommand)
  }
  $hash_graphitewriter = hiera_hash('icinga2::object::graphitewriter',undef)
  if $hash_graphitewriter {
    create_resources(icinga2::object::graphitewriter,$hash_graphitewriter)
  }
  $hash_hostgroup = hiera_hash('icinga2::object::hostgroup',undef)
  if $hash_hostgroup {
    create_resources(icinga2::object::hostgroup,$hash_hostgroup)
  }
  $hash_host = hiera_hash('icinga2::object::host',undef)
  if $hash_host {
    create_resources(icinga2::object::host,$hash_host)
  }
  $hash_idomysqlconnection = hiera_hash('icinga2::object::idomysqlconnection',undef)
  if $hash_idomysqlconnection {
    create_resources(icinga2::object::idomysqlconnection,$hash_idomysqlconnection)
  }
  $hash_idopgsqlconnection = hiera_hash('icinga2::object::idopgsqlconnection',undef)
  if $hash_idopgsqlconnection {
    create_resources(icinga2::object::idopgsqlconnection,$hash_idopgsqlconnection)
  }
  $hash_notificationcommand = hiera_hash('icinga2::object::notificationcommand',undef)
  if $hash_notificationcommand {
    create_resources(icinga2::object::notificationcommand,$hash_notificationcommand)
  }
  $hash_notification = hiera_hash('icinga2::object::notification',undef)
  if $hash_notification {
    create_resources(icinga2::object::notification,$hash_notification)
  }
  $hash_perfdatawriter = hiera_hash('icinga2::object::perfdatawriter',undef)
  if $hash_perfdatawriter {
    create_resources(icinga2::object::perfdatawriter,$hash_perfdatawriter)
  }
  $hash_scheduleddowntime = hiera_hash('icinga2::object::scheduleddowntime',undef)
  if $hash_scheduleddowntime {
    create_resources(icinga2::object::scheduleddowntime,$hash_scheduleddowntime)
  }
  $hash_servicegroup = hiera_hash('icinga2::object::servicegroup',undef)
  if $hash_servicegroup {
    create_resources(icinga2::object::servicegroup,$hash_servicegroup)
  }
  $hash_service = hiera_hash('icinga2::object::service',undef)
  if $hash_service {
    create_resources(icinga2::object::service,$hash_service)
  }
  $hash_timeperiod = hiera_hash('icinga2::object::timeperiod',undef)
  if $hash_timeperiod {
    create_resources(icinga2::object::timeperiod,$hash_timeperiod)
  }
  $hash_usergroup = hiera_hash('icinga2::object::usergroup',undef)
  if $hash_usergroup {
    create_resources(icinga2::object::usergroup,$hash_usergroup)
  }
  $hash_user = hiera_hash('icinga2::object::user',undef)
  if $hash_user {
    create_resources(icinga2::object::user,$hash_user)
  }
  $hash_zone = hiera_hash('icinga2::object::zone',undef)
  if $hash_zone {
    create_resources(icinga2::object::zone,$hash_zone)
  }
}
