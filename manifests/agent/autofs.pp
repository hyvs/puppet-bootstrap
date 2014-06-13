class p::agent::autofs (
  $roots         = hiera_hash('autofs_roots'),
  $root_resource = 'p::resource::autofs::root'
) {

  $roots_defaults = {
    require => Anchor['p::agent::autofs::begin'],
    before  => Anchor['p::agent::autofs::end']
  }

  anchor {'p::agent::autofs::begin': } ->
  anchor {'p::agent::autofs::end': }

  create_resources($root_resource, $roots, $roots_defaults)
}