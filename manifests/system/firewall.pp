class p::system::firewall (
  $opened_tcp_ports  = hiera_array('opened_tcp_ports'),
  $opened_udp_ports  = hiera_array('opened_udp_ports'),
  $opened_ports      = hiera_array('opened_ports'),
  $opened_interfaces = hiera_array('opened_interfaces')
) {

  $opened_tcp_ports.each |$port| {
    p::resource::firewall::tcp {"${port}": port => $port }
  }

  $opened_udp_ports.each |$port| {
    p::resource::firewall::udp {"${port}": port => $port }
  }

  $opened_ports.each |$port| {
    p::resource::firewall::port {"${port}": port => $port }
  }

  $opened_interfaces.each |$interface| {
    p::resource::firewall::interface {"${interface}": }
  }

}