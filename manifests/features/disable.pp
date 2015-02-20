# Disable Icinga 2 Features/Modules
define icinga2::features::disable () {
  exec { "icinga2 disable feature ${name}":
    user    => 'root',
    path    => '/usr/bin:/usr/sbin:/bin/:/sbin',
    command => "/usr/sbin/icinga2 feature disable ${name}",
    unless  => "[ ! -f /etc/icinga2/features-enabled/${name}.conf ]",
    require => Class['icinga2::node::install::packages'],
  }
}
