class p::system::files (
  $files    = hiera_hash('files'),
  $resource = 'p::resource::file'
) {

  create_resources($resource, $files)

}