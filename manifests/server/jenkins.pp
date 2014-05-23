class p::server::jenkins (
  $firewall = true,
  $port     = 8080
) {

  p::resource::apt::repo {'jenkins':
    location    => 'http://pkg.jenkins-ci.org/debian',
    release     => 'binary',
    repos       => '',
    key         => 'D50582E6',
    key_source  => 'http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key',
    include_src => false,
    stage       => 'repos',
  }

  p::resource::firewall::tcp {'jenkins':
    enabled => any2bool($firewall),
    port    => $port,
    stage   => 'firewall',
  }

  anchor { 'p::server::jenkins::begin': }

  package {'jenkins':
    ensure  => 'installed',
    require => [Anchor['p::server::jenkins::begin'], P::Resource::Apt::Repo['jenkins']],
  } ->
  service {'jenkins':
    ensure => 'running',
    before => Anchor['p::server::jenkins::end'],
  }

  anchor {'p::server::jenkins::end':
    require => Anchor['p::server::jenkins::begin'],
  }

}