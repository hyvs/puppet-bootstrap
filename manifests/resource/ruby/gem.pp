define p::resource::ruby::gem (
  $version  = undef
) {

  if !defined(Package['ruby']) and !defined(P::Resource::Package['ruby']) {
    p::resource::package { 'ruby': }
  }

  p::resource::package { $name:
    version  => $version,
    provider => 'gem',
    require  => Package['ruby'],
  }

}