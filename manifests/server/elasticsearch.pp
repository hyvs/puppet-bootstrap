class p::server::elasticsearch (
  $version  = undef
) {

  if !defined(Class['p::repo::elasticsearch']) {
    class {'p::repo::elasticsearch': }
  }

   p::resource::package { 'elasticsearch': version => $version }

}