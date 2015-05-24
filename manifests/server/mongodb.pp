class p::server::mongodb (
  $firewall   = false,
  $port       = 27017,
  $version    = '3.0.2',
  $listen_all = false
) {

  if !defined(Class['p::repo::tengen']) {
    class {'p::repo::tengen': }
  }

  anchor {'p::server::mongodb::begin': }

  p::resource::firewall::tcp {'mongodb':
    enabled => $firewall,
    port    => $port,
    require => Anchor['p::server::mongodb::begin'],
    before  => Anchor['p::server::mongodb::end'],
  }

  p::resource::package {['mongodb-org', 'mongodb-org-server', 'mongodb-org-shell', 'mongodb-org-mongos', 'mongodb-org-tools']:
    version => $version,
    require => Anchor['p::server::mongodb::begin'],
    before  => Anchor['p::server::mongodb::end'],
  } ->
  anchor {'p::server::mongodb::after_packages': }

  if $listen_all {
    file_line { 'mongodb enable listen on all interfaces':
      require => Anchor['p::server::mongodb::after_packages'],
      path  => '/etc/mongod.conf',
      line  => '#bind_ip = 127.0.0.1',
      match => '^(\#)?bind_ip ',
      notify => Service['mongod'],
    }
  }

  service { "mongod":
    require => P::Resource::Package['mongodb-org-server'],
    ensure  => "running",
    enable  => "true",
  }

  anchor {'p::server::mongodb::end':
    require => Anchor['p::server::mongodb::begin'],
  }

}