class p::system::directories (
  $directories = hiera_hash('directories'),
  $resource    = 'p::resource::directory'
) {

  create_resources($resource, $directories)

}