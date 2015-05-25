class p::system::directories (
  $directories = hiera_hash('directories'),
  $resource    = 'p::resource::directory'
) {

  $defaults = {
    require => Anchor['p::system::directories::begin'],
    before  => Anchor['p::system::directories::end'],
  }
  
     anchor { 'p::system::directories::begin': }
  -> anchor { 'p::system::directories::end':   }

  create_resources($resource, $directories, $defaults)

}