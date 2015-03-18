# == Class: icinga2::feature::notification
#
# Manage and enable the NotificationComponent of Icinga2
#
class icinga2::feature::notification (
  $enable_ha = true,
) {

  validate_bool($enable_ha)
  ::icinga2::feature { 'notification':
    content => template('icinga2/feature/notification.conf.erb'),
  }
}
