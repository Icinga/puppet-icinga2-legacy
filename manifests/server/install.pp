# == Class: icinga2::server::install
#
# This class installs the server components for the Icinga 2 monitoring system.
#
# === Parameters
#
# Coming soon...
#
# === Examples
#
# Coming soon...
#

class icinga2::server::install inherits icinga2::server {

  include icinga2::server
  #Apply our classes in the right order. Use the squiggly arrows (~>) to ensure that the
  #class left is applied before the class on the right and that it also refreshes the
  #class on the right.
  #
  #Here, we're installing the IDO DB package in the ::packages class, then using the execs
  # to load the DB schema:
  class{'icinga2::server::install::packages':} ~>
  class{'icinga2::server::install::execs':} ->
  Class['icinga2::server::install']

}

#Install packages for Icinga 2's IDO database connection:
class icinga2::server::install::packages inherits icinga2::server {

  include icinga2::server

  #Pick the right DB lib package name based on the database type the user selected:
  case $server_db_type {
    #MySQL:
    'mysql': { $icinga2_server_db_connector_package = 'icinga2-ido-mysql'}
    #Postgres:
    'pgsql': { $icinga2_server_db_connector_package = 'icinga2-ido-pgsql'}
    default: { fail("${icinga2::params::server_db_type} is not a supported database! Please specify either 'mysql' for MySQL or 'pgsql' for Postgres.") }
  }

  #Install the IDO database connector package. See:
  #http://docs.icinga.org/icinga2/latest/doc/module/icinga2/toc#!/icinga2/latest/doc/module/icinga2/chapter/getting-started#configuring-db-ido
  package {$icinga2_server_db_connector_package:
    ensure   => installed,
    provider => $package_provider,
  }

}

#This class contains exec resources
class icinga2::server::install::execs inherits icinga2::server {

  include icinga2::server

  #Configure database schemas and IDO modules
  case $server_db_type {
    'mysql': {
      #Load the MySQL DB schema:
      exec { 'mysql_schema_load':
        user    => 'root',
        path    => '/usr/bin:/usr/sbin:/bin/:/sbin',
        command => "mysql -u ${db_user} -p${db_password} ${db_name} < ${server_db_schema_path} && touch /etc/icinga2/mysql_schema_loaded.txt",
        creates => '/etc/icinga2/mysql_schema_loaded.txt',
        require => Class['icinga2::server::install::packages'],
      }
      #Enable the MySQL IDO module:
      exec { 'mysql_module_enable':
        user    => 'root',
        path    => '/usr/bin:/usr/sbin:/bin/:/sbin',
        command => '/usr/sbin/icinga2 enable feature ido-mysql && touch /etc/icinga2/mysql_module_loaded.txt',
        creates => '/etc/icinga2/mysql_module_loaded.txt',
        require => Exec['mysql_schema_load'],
      }
    }

    'pgsql': {
      #Load the Postgres DB schema:
      exec { 'postgres_schema_load':
        user    => 'root',
        path    => '/usr/bin:/usr/sbin:/bin/:/sbin',
        command => "su - postgres -c 'export PGPASSWORD='\\''${db_password}'\\'' && psql -U ${db_user} -h localhost -d ${db_name} < ${server_db_schema_path}' && export PGPASSWORD='' && touch /etc/icinga2/postgres_schema_loaded.txt",
        creates => '/etc/icinga2/postgres_schema_loaded.txt',
        require => Class['icinga2::server::install::packages'],
      }
      #Enable the Postgres IDO module:
      exec { 'postgres_module_enable':
        user    => 'root',
        path    => '/usr/bin:/usr/sbin:/bin/:/sbin',
        command => '/usr/sbin/icinga2 enable feature ido-pgsql && touch /etc/icinga2/postgres_module_loaded.txt',
        creates => '/etc/icinga2/postgres_module_loaded.txt',
        require => Exec['postgres_schema_load'],
      }
    }

    default: { fail("${server_db_type} is not supported!") }
  }
}
