class p::server::activemq (
  $firewall = true,
  $activemq = 61616
) {

  anchor {'p::server::activemq::begin': } ->
  class {'::activemq': } ->
  p::resource::firewall::tcp {'activemq':
    port    => $port,
    enabled => any2bool($firewall),
  } ->
  anchor {'p::server::activemq::end':}

}