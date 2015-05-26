class p::language::nodejs (
  $packages         = hiera_hash('npm_packages'),
  $version          = hiera('nodejs_version', "installed"),
  $package_resource = 'p::resource::nodejs::package'
) {

  if !defined(Class['p::repo::nodesource']) {
    class {'p::repo::nodesource': }
  }

  $packages_defaults = {
    require => P::Resource::Package['nodejs'],
  }

  p::resource::package { 'nodejs': version => $version }

  create_resources($package_resource, $packages, $packages_defaults)

}