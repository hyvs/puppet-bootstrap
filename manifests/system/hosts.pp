class p::system::hosts (
  $hosts    = hiera_hash('hosts'),
  $resource = 'p::resource::host'
) {

  create_resources($resource, $hosts)

}