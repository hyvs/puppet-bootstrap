class p::system::files (
  $files    = hiera_hash('files'),
  $resource = 'p::resource::file'
) {

  $defaults = {
    require => Anchor['p::system::files::begin'],
    before  => Anchor['p::system::files::end'],
  }

     anchor { 'p::system::files::begin': }
  -> anchor { 'p::system::files::end':   }

  create_resources($resource, $files, $defaults)

}