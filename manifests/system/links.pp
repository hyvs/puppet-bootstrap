class p::system::links (
  $links    = hiera_hash('links'),
  $resource = 'p::resource::link'
) {

  create_resources($resource, $links)

}