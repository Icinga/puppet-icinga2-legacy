# == Class: icinga2::features
#
# Managing the enabled features of Icinga2
#
class icinga2::features {

  if $::icinga2::default_features == true {
    ::icinga2::feature { 'checker': }
    include ::icinga2::feature::notification
    include ::icinga2::feature::mainlog
  }
  else {
    validate_array($::icinga2::default_features)

    if ! member($::icinga2::default_features, 'checker') {
      warning('The feature "checker" is a core feature of Icinga 2, are you sure you want to disable it?')
    }

    ::icinga2::features::load { $::icinga2::default_features: }
  }

}
