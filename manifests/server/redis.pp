class p::server::redis (
  $version    = hiera('redis_version'),
  $firewall   = false,
  $port       = 6379
) {

  if !defined(Class['p::repo::dotdeb']) {
    class {'p::repo::dotdeb': }
  }

     p::resource::package       { ['redis-server']: version => $version }
  -> p::resource::firewall::tcp { 'redis':                             enabled => $firewall, port    => $port  }
  -> service                    { "redis-server":                      ensure  => "running", enable  => "true" }
}