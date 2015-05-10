class p::language::ruby (
  $gem_resource = 'p::resource::ruby::gem',
  $gems         = hiera_hash('gems'),
  $version      = undef
) {

  $gems_defaults = {
    require  => P::Resource::Package['ruby'],
    before   => Anchor['p::language::ruby::end'],
  }

     anchor {'p::language::ruby::begin': }
  -> p::resource::package { 'ruby': version => $version }
  -> anchor {'p::language::ruby::end': }

  create_resources($gem_resource, $gems, $gems_defaults)

}