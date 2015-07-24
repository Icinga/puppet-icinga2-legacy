# Class: icinga2::nrpe::install
#
# This subclass installs NRPE and Nagios plugin packages on Icinga client machines.
#
class icinga2::nrpe::install {
  #Apply our subclasses in the right order. Use the squiggly arrows (~>) to ensure that the
  #class left is applied before the class on the right and that it also refreshes the
  #class on the right.
  class {'::icinga2::nrpe::install::repos':} ~>
  class {'::icinga2::nrpe::install::packages':} ~>
  class {'::icinga2::nrpe::install::execs':} ->
  Class['::icinga2::nrpe::install']
}

