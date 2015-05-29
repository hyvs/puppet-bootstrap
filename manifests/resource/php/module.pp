define p::resource::php::module (
  $enabled  = true
) {

  if !defined(Package['php5-cli']) and !defined(P::Resource::Package['php5-cli']) {
    p::resource::package { 'php5-cli': }
  }

  if $enabled {
    $ensure = 'present'
  } else {
    $ensure = 'absent'
  }

  p::resource::package { $name:
    ensure  => $ensure,
    require => Package['php5-cli'],
  }

}