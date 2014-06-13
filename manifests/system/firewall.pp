class p::system::firewall (
  $opened_tcp_ports = hiera_array('opened_tcp_ports'),
  $opened_udp_ports = hiera_array('opened_udp_ports'),
  $opened_ports     = hiera_array('opened_ports'),
  $opened_interfaces = hiera_array('opened_interfaces')
) {

  anchor {'p::system::firewall::begin': } ->
  anchor {'p::system::firewall::end': }

  $opened_tcp_ports.each |$port| {
    p::resource::firewall::tcp {"${port}":
      port    => $port,
      require => Anchor['p::system::firewall::begin'],
      before  => Anchor['p::system::firewall::end'],
    }
  }

  $opened_udp_ports.each |$port| {
    p::resource::firewall::udp {"${port}":
      port    => $port,
      require => Anchor['p::system::firewall::begin'],
      before  => Anchor['p::system::firewall::end'],
    }
  }

  $opened_ports.each |$port| {
    p::resource::firewall::port {"${port}":
      port    => $port,
      require => Anchor['p::system::firewall::begin'],
      before  => Anchor['p::system::firewall::end'],
    }
  }

  $opened_interfaces.each |$interface| {
    p::resource::firewall::interface {"${interface}":
      require => Anchor['p::system::firewall::begin'],
      before  => Anchor['p::system::firewall::end'],
    }
  }

}