class p::language::nodejs (
  $packages         = hiera_hash('npm_packages'),
  $version          = hiera('nodejs_version'),
  $package_resource = 'p::resource::nodejs::package'
) {

  if !defined(Class['p::repo::nodesource']) {
    class {'p::repo::nodesource': }
  }

  $packages_defaults = {
    require => P::Resource::Package['nodejs'],
    before  => Anchor['p::language::nodejs::end']
  }

     anchor               { 'p::language::nodejs::begin':                     }
  -> p::resource::package { 'nodejs':                     version => $version }
  -> anchor               { 'p::language::nodejs::end':                       }

  create_resources($package_resource, $packages, $packages_defaults)

}