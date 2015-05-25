class p::system::links (
  $links    = hiera_hash('links'),
  $resource = 'p::resource::link'
) {

  $defaults = {
    require => Anchor['p::system::links::begin'],
    before  => Anchor['p::system::links::end'],
  }

     anchor { 'p::system::links::begin': }
  -> anchor { 'p::system::links::end':   }

  create_resources($resource, $links, $defaults)

}