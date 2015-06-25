class p::server::mongodb (
  $version    = hiera('mongodb_version'),
  $firewall   = false,
  $port       = 27017,
  $listen_all = false,
  $listen_only = undef,
  $replica_set = undef,
  $data_dir    = undef
) {

  if !defined(Class['p::repo::tengen']) {
    class {'p::repo::tengen': }
  }

     p::resource::package       { ['mongodb-org', 'mongodb-org-server', 'mongodb-org-shell', 'mongodb-org-mongos', 'mongodb-org-tools']: version => $version }
  -> p::resource::firewall::tcp { 'mongodb':                            enabled => $firewall, port    => $port  }
  -> service                    { "mongod":                             ensure  => "running", enable  => "true" }

  if ($listen_only) {
    file_line { 'mongodb enable listen on specified interfaces':
      require => [P::Resource::Package['mongodb-org'], P::Resource::Package['mongodb-org-server']],
      path    => '/etc/mongod.conf',
      line    => "bind_ip=${listen_only}",
      match   => '^(\#)?bind_ip ',
      notify   => Service['mongod'],
    }
  } else {
    if $listen_all {
      file_line { 'mongodb enable listen on all interfaces':
        require => [P::Resource::Package['mongodb-org'], P::Resource::Package['mongodb-org-server']],
        path    => '/etc/mongod.conf',
        line    => '#bind_ip=127.0.0.1',
        match   => '^(\#)?bind_ip ',
        notify   => Service['mongod'],
      }
    }
  }

  if $replica_set {
    file_line { "mongodb enable replica set mode with name ${replica_set}":
      require => [P::Resource::Package['mongodb-org'], P::Resource::Package['mongodb-org-server']],
      path    => '/etc/mongod.conf',
      line    => "replSet=${replica_set}",
      match   => '^(\#)?replSet',
      notify   => Service['mongod'],
    }
  }

  if $data_dir {
       exec { "move mongodb data dir to custom location ${data_dir} if need":
         cwd     => "${data_dir}",
         command => "service mongod stop; cp -R /var/lib/mongodb/* ${data_dir}/",
         unless  => "[ -f ${data_dir}/storage.bson ]",
         require => [P::Resource::Package['mongodb-org'], P::Resource::Package['mongodb-org-server']],
         notify  => Service['mongod'],
       }
    -> file_line { "mongodb set custom db path to ${data_dir}":
         path   => '/etc/mongod.conf',
         line   => "dbpath=${data_dir}",
         match  => '^(\#)?dbpath',
         notify => Service['mongod'],
       }
  }

  if $port and $port != 27017 {
    file_line { "mongodb set custom port to ${port}":
      require => [P::Resource::Package['mongodb-org'], P::Resource::Package['mongodb-org-server']],
      path    => '/etc/mongod.conf',
      line    => "port=${port}",
      match   => '^(\#)?port',
      notify   => Service['mongod'],
    }
  }

}