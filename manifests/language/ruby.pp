class p::language::ruby (
  $gems         = hiera_hash('gems'),
  $version      = hiera('ruby_version', "installed"),
  $gem_resource = 'p::resource::ruby::gem'
) {

  $gems_defaults = {
    require  => P::Resource::Package['ruby'],
  }

  p::resource::package { 'ruby': version => $version }

  create_resources($gem_resource, $gems, $gems_defaults)

}