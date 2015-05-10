define p::resource::ruby::gem (
  $version  = undef
) {

  p::resource::package { $name:
    version  => $version,
    provider => 'gem',
    require  => Package['ruby'],
  }

}