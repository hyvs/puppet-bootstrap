define p::resource::firewall::subnet_gateway (
  $subnet,
  $interface
) {

    firewall { "200 use ${interface} as outgoing gateway from ${subnet}":
      table   => 'nat',
      chain   => 'POSTROUTING',
      proto   => 'all',
      jump    => 'MASQUERADE',
      source  => $subnet,
      outiface => $interface
    }

}