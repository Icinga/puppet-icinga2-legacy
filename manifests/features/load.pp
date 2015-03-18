# == Define: icinga2::features::load
#
# Enable a feature by including it
#
define icinga2::features::load {
  if defined("::icinga2::feature::${name}") {
    include "::icinga2::feature::${name}"
  } else {
    ::icinga2::feature { $name: }
  }
}
