class p::system::packages (
  $packages = hiera_hash('packages'),
  $resource = 'p::resource::package'
) {

  $defaults = {
    require => Anchor['p::system::packages::begin'],
    before  => Anchor['p::system::packages::end'],
  }

     anchor { 'p::system::packages::begin': }
  -> anchor { 'p::system::packages::end':   }

  create_resources($resource, $packages, $defaults)

}