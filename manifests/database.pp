# == Class: icinga2::database
#
# Managing Icinga2's IDO database
#
class icinga2::database {

  validate_re($::icinga2::db_type, '^(mysql|pgsql)$', "Database type ${::icinga2::db_type} is not supported!")

  if $::icinga2::db_schema {
    $db_schema = $::icinga2::db_schema
  }
  else {
    $db_schema = $::icinga2::db_type ? {
      'mysql' => $::icinga2::params::db_schema_mysql,
      'pgsql' => $::icinga2::params::db_schema_pgsql,
      default => undef,
    }
  }
  validate_absolute_path($db_schema)

  if $::icinga2::db_type == 'mysql' {
    include ::icinga2::feature::ido_mysql

    # TODO: is there a better way?
    Package['icinga2-ido-mysql'] ->
    exec { 'mysql_schema_load':
      user    => 'root',
      path    => $::path,
      command => "mysql -H '${::icinga2::db_host}' -u '${::icinga2::db_user}' -p'${::icinga2::db_pass}' '${::icinga2::db_name}' < '${db_schema}' && touch /etc/icinga2/mysql_schema_loaded.txt",
      creates => '/etc/icinga2/mysql_schema_loaded.txt',
    }
  }
  elsif $::icinga2::db_type == 'pgsql' {
    include ::icinga2::feature::ido_pgsql

    # TODO: is there a better way?
    if $::icinga2::db_port {
      $port = "-p ${::icinga2::db_port}"
    } else {
      $port = undef
    }

    Package['icinga2-ido-pgsql'] ->
    exec { 'postgres_schema_load':
      user        => 'root',
      path        => $::path,
      environment => [
        "PGPASSWORD=${::icinga2::db_pass}",
      ],
      command     => "psql -U '${::icinga2::db_user}' -h '${::icinga2::db_host}' ${port} -d '${::icinga2::db_name}' < '${db_schema}' && touch /etc/icinga2/postgres_schema_loaded.txt",
      creates     => '/etc/icinga2/postgres_schema_loaded.txt',
    }
  }

}
