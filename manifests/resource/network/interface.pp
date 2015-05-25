define p::resource::network::interface (
  $ip,
  $netmask,
  $broadcast,
  $comment   = undef,
  $auto      = true,
  $type      = 'static',
  $dir       = '/etc/network/interfaces.d'
) {

  file { "${dir}/${name}.cfg":
    content => template('p/network/interface.cfg.erb'),
  }

}