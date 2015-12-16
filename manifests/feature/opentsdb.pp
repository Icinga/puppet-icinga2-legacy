# == Class: icinga2::feature::opentsdb
#
# Manage and enable opentsdb of Icinga2
#
class icinga2::feature::opentsdb (
  $host = '127.0.0.1',
  $port = 4242,
) {

  ::icinga2::object::opentsdbwriter { 'opentsdb':
    host => $host,
    port => $port,
  }
  ::icinga2::feature { 'opentsdb':
    manage_file => false
  }
}
