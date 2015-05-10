class p::language::nodejs (
  $version                = undef,
  $package_resource       = 'p::resource::nodejs::package',
  $packages               = hiera_hash('npm_packages')
) {

  class {'p::repo::nodesource': }

  $packages_defaults = {
    require => P::Resource::Package['nodejs'],
    before  => Anchor['p::language::nodejs::end']
  }

     anchor {'p::language::nodejs::begin': }
  -> p::resource::package { 'nodejs': version => $version }
  -> anchor {'p::language::nodejs::end': }

  create_resources($package_resource, $packages, $packages_defaults)

}