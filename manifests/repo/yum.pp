# Setup yum repository for Icinga
#
class icinga2::repo::yum (
  $baseurl = "http://packages.icinga.org/epel/${::operatingsystemmajrelease}/release/",
) {
  # Add the official Icinga Yum repository or a mirror
  yumrepo { 'icinga2_yum_repo':
    baseurl  => $baseurl,
    descr    => 'Icinga 2 Yum repository',
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => 'http://packages.icinga.org/icinga.key',
  }
}
