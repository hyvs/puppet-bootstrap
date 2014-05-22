class p::system::directories (
  $directories = hiera_hash('directories'),
  $resource    = 'p::resource::directory'
) {

  anchor {'p::system::directories::begin': }
  
  $defaults = {
    require => Anchor['p::system::directories::begin'],
    before  => Anchor['p::system::directories::end'],
  }
  
  create_resources($resource, $directories, $defaults)
  
  anchor {'p::system::directories::end':
    require => Anchor['p::system::directories::begin'],
  }
  
}