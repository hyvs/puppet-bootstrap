class p::system::packages (
  $packages = hiera_hash('packages'),
  $resource = 'p::resource::package'
) {

  anchor {'p::system::packages::begin': }
  
  $defaults = {
    require => Anchor['p::system::packages::begin'],
    before  => Anchor['p::system::packages::end'],
  }
  
  create_resources($resource, $packages, $defaults)
  
  anchor {'p::system::packages::end':
    require => Anchor['p::system::packages::begin'],
  }
  
}