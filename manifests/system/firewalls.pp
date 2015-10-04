class p::system::firewalls (
  $opened_tcp_ports  = hiera_array('opened_tcp_ports'),
  $opened_udp_ports  = hiera_array('opened_udp_ports'),
  $opened_ports      = hiera_array('opened_ports'),
  $opened_interfaces = hiera_array('opened_interfaces'),
  $subnet_gateways   = hiera_hash('subnet_gateways')
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

  $subnet_gateways.each |$subnet,$interface| {
    p::resource::firewall::subnet_gateway {"${subnet} => ${interface}": subnet => $subnet, interface => $interface }
  }

}