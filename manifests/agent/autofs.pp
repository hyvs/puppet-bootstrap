class p::agent::autofs (
  $roots         = hiera_hash('autofs_roots'),
  $root_resource = 'p::resource::autofs::root'
) {

  $roots_defaults = {
    require => P::Resource::Package['/etc/auto.master.d'],
    before  => Anchor['p::agent::autofs::end'],
    notify  => Service['autofs'],
  }

  anchor {'p::agent::autofs::begin': } ->
  p::resource::package {'autofs': } ->
  p::resource::directory {'/etc/auto.master.d':
  } ->
  service {'autofs':
    ensure => 'running',
    enable => true,
  } ->
  anchor {'p::agent::autofs::end': }

  create_resources($root_resource, $roots, $roots_defaults)
}