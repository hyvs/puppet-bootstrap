class p::agent::autofs (
  $roots         = hiera_hash('autofs_roots'),
  $root_resource = 'p::resource::autofs::root'
) {

  $roots_defaults = {
    require => P::Resource::Directory['/etc/auto.master.d'],
    before  => Service['autofs'],
    notify  => Service['autofs'],
  }

     p::resource::package   { 'autofs':                  }
  -> p::resource::directory { '/etc/auto.master.d':      }
  -> service                { 'autofs': ensure => 'running', enable => true}

  create_resources($root_resource, $roots, $roots_defaults)

}