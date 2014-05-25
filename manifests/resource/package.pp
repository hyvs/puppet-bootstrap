define p::resource::package (
  $ensure   = present,
  $provider = undef,
  $source   = undef,
  $version  = undef
) {

  if undef != $version {
    $real_ensure  = $version
  } else {
    $real_ensure = 'present'
  }

  if ! defined(::Package[$name]) {
    ::package {$name:
      name     => $name,
      ensure   => $real_ensure,
      source   => $source,
      provider => $provider,
    }
  }

}