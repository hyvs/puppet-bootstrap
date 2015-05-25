class p::server::mongodb (
  $version    = hiera('mongodb_version'),
  $firewall   = false,
  $port       = 27017,
  $listen_all = false
) {

  if !defined(Class['p::repo::tengen']) {
    class {'p::repo::tengen': }
  }

     anchor                     { 'p::server::mongodb::begin':          }
  -> p::resource::package       { ['mongodb-org', 'mongodb-org-server', 'mongodb-org-shell', 'mongodb-org-mongos', 'mongodb-org-tools']: version => $version }
  -> anchor                     { 'p::server::mongodb::after_packages': }
  -> p::resource::firewall::tcp { 'mongodb':                            enabled => $firewall, port    => $port  }
  -> service                    { "mongod":                             ensure  => "running", enable  => "true" }
  -> anchor                     { 'p::server::mongodb::end':            }

  if $listen_all {
    file_line { 'mongodb enable listen on all interfaces':
      require => Anchor['p::server::mongodb::after_packages'],
      before  => Anchor['p::server::mongodb::end'],
      path    => '/etc/mongod.conf',
      line    => '#bind_ip = 127.0.0.1',
      match   => '^(\#)?bind_ip ',
      notify   => Service['mongod'],
    }
  }

}