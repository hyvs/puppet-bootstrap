class p::system::links (
  $links    = hiera_hash('links'),
  $resource = 'p::resource::link'
) {

  anchor {'p::system::links::begin': }
  
  $defaults = {
    require => Anchor['p::system::links::begin'],
    before  => Anchor['p::system::links::end'],
  }
  
  create_resources($resource, $links, $defaults)
  
  anchor {'p::system::links::end':
    require => Anchor['p::system::links::begin'],
  }
  
}