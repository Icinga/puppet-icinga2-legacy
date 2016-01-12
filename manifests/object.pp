# == Class: icinga2::object
#
# Auto loading of icinga2 defined types from hiera.
# All parameters used here should be hashes in hiera.
#
class icinga2::object(
  $apiuser = {},
  $apply_dependency = {},
  $apply_notification_to_host = {},
  $apply_notification_to_service = {},
  $apply_service_to_host = {},
  $apply_service = {},
  $checkcommand = {},
  $dependency = {},
  $eventcommand = {},
  $graphitewriter = {},
  $hostgroup = {},
  $host = {},
  $idomysqlconnection = {},
  $idopgsqlconnection = {},
  $notificationcommand = {},
  $notification = {},
  $perfdatawriter = {},
  $scheduleddowntime = {},
  $servicegroup = {},
  $service = {},
  $timeperiod = {},
  $usergroup = {},
  $user = {},
  $zone = {},
) {
  create_resources(icinga2::object::apiuser, $apiuser)
  create_resources(icinga2::object::apply_dependency, $apply_dependency)
  create_resources(icinga2::object::apply_notification_to_host, $apply_notification_to_host)
  create_resources(icinga2::object::apply_notification_to_service, $apply_notification_to_service)
  # DEPRECATED: remove old named variable
  if $apply_service_to_host {
    warning("DEPRECATED: Please use 'icinga2::object::apply_service' instead of 'apply_service_to_host")
    create_resources(icinga2::object::apply_service, $apply_service_to_host)
  }
  create_resources(icinga2::object::apply_service, $apply_service)
  create_resources(icinga2::object::checkcommand, $checkcommand)
  create_resources(icinga2::object::dependency, $dependency)
  create_resources(icinga2::object::eventcommand, $eventcommand)
  create_resources(icinga2::object::graphitewriter, $graphitewriter)
  create_resources(icinga2::object::hostgroup, $hostgroup)
  create_resources(icinga2::object::host, $host)
  create_resources(icinga2::object::idomysqlconnection, $idomysqlconnection)
  create_resources(icinga2::object::idopgsqlconnection, $idopgsqlconnection)
  create_resources(icinga2::object::notificationcommand, $notificationcommand)
  create_resources(icinga2::object::notification, $notification)
  create_resources(icinga2::object::perfdatawriter, $perfdatawriter)
  create_resources(icinga2::object::scheduleddowntime, $scheduleddowntime)
  create_resources(icinga2::object::servicegroup, $servicegroup)
  create_resources(icinga2::object::service, $service)
  create_resources(icinga2::object::timeperiod, $timeperiod)
  create_resources(icinga2::object::usergroup, $usergroup)
  create_resources(icinga2::object::user, $user)
  create_resources(icinga2::object::zone, $zone)
}
