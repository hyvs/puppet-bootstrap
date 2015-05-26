class p::server::mongodb (
  $version    = hiera('mongodb_version'),
  $firewall   = false,
  $port       = 27017,
  $listen_all = false
) {

  if !defined(Class['p::repo::tengen']) {
    class {'p::repo::tengen': }
  }

     p::resource::package       { ['mongodb-org', 'mongodb-org-server', 'mongodb-org-shell', 'mongodb-org-mongos', 'mongodb-org-tools']: version => $version }
  -> p::resource::firewall::tcp { 'mongodb':                            enabled => $firewall, port    => $port  }
  -> service                    { "mongod":                             ensure  => "running", enable  => "true" }

  if $listen_all {
    file_line { 'mongodb enable listen on all interfaces':
      require => [P::Resource::Package['mongodb-org'], P::Resource::Package['mongodb-org-server']],
      path    => '/etc/mongod.conf',
      line    => '#bind_ip = 127.0.0.1',
      match   => '^(\#)?bind_ip ',
      notify   => Service['mongod'],
    }
  }

}