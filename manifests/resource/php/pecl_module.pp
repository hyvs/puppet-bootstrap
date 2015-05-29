define p::resource::php::pecl_module (
  $enabled = true
  $version = undef
) {

  if !defined(Package['php5-cli']) and !defined(P::Resource::Package['php5-cli']) {
    p::resource::package { 'php5-cli': }
  }

  if $enabled {
    $ensure = 'present'
  } else {
    $ensure = 'absent'
  }

  # @todo

}