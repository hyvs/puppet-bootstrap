class p::system::packages (
  $packages = hiera_hash('packages'),
  $resource = 'p::resource::package'
) {

  create_resources($resource, $packages)

}