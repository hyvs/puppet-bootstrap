class p::server::jenkins (
  $firewall = true,
  $port     = 8080,
  $version  = undef
) {

  if !defined(Class['p::repo::jenkins']) {
    class {'p::repo::jenkins': }
  }

     p::resource::package       { 'jenkins': version => $version }
  -> p::resource::firewall::tcp { 'jenkins': enabled => $firewall, port => $port }

}