class p::system::files (
  $files    = hiera_hash('files'),
  $resource = 'p::resource::file'
) {

  anchor {'p::system::files::begin': }
  
  $defaults = {
    require => Anchor['p::system::files::begin'],
    before  => Anchor['p::system::files::end'],
  }
  
  create_resources($resource, $files, $defaults)
  
  anchor {'p::system::files::end':
    require => Anchor['p::system::files::begin'],
  }
  
}