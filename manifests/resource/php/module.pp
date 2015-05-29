define p::resource::php::module (
  $enabled      = true,
  $package_name = undef
) {

  if !defined(Package['php5-cli']) and !defined(P::Resource::Package['php5-cli']) {
    p::resource::package { 'php5-cli': }
  }

  if $enabled {
    $ensure = 'present'
  } else {
    $ensure = 'absent'
  }

  if $package_name {
    $real_package_name = $package_name
  } else {
    $real_package_name = "php5-${name}"
  }

  p::resource::package { $real_package_name:
    ensure  => $ensure,
    require => Package['php5-cli'],
  }

}