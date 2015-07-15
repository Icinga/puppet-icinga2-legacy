# == Class: icinga2::install
#
# This class installs the Icinga 2 daemon.
#
# === Parameters
#
# Coming soon...
#
# === Examples
#
# Coming soon...
#

class icinga2::install inherits icinga2 {

  #Apply our classes in the right order. Use the squiggly arrows (~>) to ensure that the
  #class left is applied before the class on the right and that it also refreshes the
  #class on the right.

  #Here, we're setting up the package repos first, then installing the packages, then
  #running any execs that are needed to set things up further:
  class{'::icinga2::install::repos':} ~>
  class{'::icinga2::install::packages':} ~>
  class{'::icinga2::install::execs':} ->
  Class['icinga2::install']

}
