# Enable Features for Icinga 2
class icinga2::features (
  $enabled_features = undef,
  $disabled_features = undef,
) {

  # Do some checking
  validate_array($enabled_features)
  validate_array($disabled_features)

  #Compare the enabled and disabled feature arrays
  #Remove enabled features that are also listed to be disabled
  $updated_enabled_features = difference($enabled_features,$disabled_features)

  #Pass the disabled features array to the define for looping
  icinga2::features::disable { $disabled_features: }

  #Pass the features array to the define for looping
  icinga2::features::enable { $updated_enabled_features: }

}
