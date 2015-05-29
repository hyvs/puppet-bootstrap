define p::resource::php::directive (
  $entry,
  $value
) {

  if !defined(Package['php5-cli']) and !defined(P::Resource::Package['php5-cli']) {
    p::resource::package { 'php5-cli': }
  }

  # @todo

}