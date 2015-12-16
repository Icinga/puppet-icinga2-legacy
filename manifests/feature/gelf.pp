# == Class: icinga2::feature::gelf
#
# Manage and enable gelf of Icinga2
#
class icinga2::feature::gelf (
  $host   = '127.0.0.1',
  $port   = 12201,
  $source = undef,
) {

  ::icinga2::object::gelfwriter { 'gelf':
    host   => $host,
    port   => $port,
    source => $source,
  }
  ::icinga2::feature { 'gelf':
    manage_file => false,
  }
}
