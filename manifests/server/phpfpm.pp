class p::server::phpfpm (
  $version  = undef,
  $pools = hiera_hash('phpfpm_pools'),
  $pool_resource = 'p::resource::phpfpm::pool'
) {

  $pools_defaults = {
    require => P::Resource::Package['php5-fpm'],
    notify  => Service['php5-fpm'],
  }

  if !defined(Class['p::repo::dotdeb']) {
    class {'p::repo::dotdeb': }
  }

     p::resource::package { 'php5-fpm': version => $version }
  -> service              { 'php5-fpm': ensure => 'running', enable => true }

  create_resources($pool_resource, $pools, $pools_defaults)

}