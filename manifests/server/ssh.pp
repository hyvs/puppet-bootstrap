class p::server::ssh (
  $firewall = true,
  $port     = 22
) {

  p::resource::firewall::tcp {'ssh':
    enabled => any2bool($firewall),
    port    => any2int($port),
    stage   => 'firewall',
  }

  anchor {'p::server::ssh::begin': } ->
  p::resource::package {'openssh-server': } ->
  anchor {'p::server::ssh::end': }

}