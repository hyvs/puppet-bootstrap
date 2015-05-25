class p::language::ruby (
  $gems         = hiera_hash('gems'),
  $version      = hiera('ruby_version'),
  $gem_resource = 'p::resource::ruby::gem'
) {

  $gems_defaults = {
    require  => P::Resource::Package['ruby'],
    before   => Anchor['p::language::ruby::end'],
  }

     anchor               { 'p::language::ruby::begin':                     }
  -> p::resource::package { 'ruby':                     version => $version }
  -> anchor               { 'p::language::ruby::end':                       }

  create_resources($gem_resource, $gems, $gems_defaults)

}