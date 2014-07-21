class p::system::network (
  $interfaces = hiera_hash('network_interfaces')
) {

  $interfaces_file = "/etc/network/interfaces"

  if !$interfaces['lo'] {
    fail("No lo interfaces defined")
  }

  if !$interfaces['eth0'] {
    fail("No eth0 interfaces defined")
  }

  anchor {'p::system::network::begin': } ->
  p::resource::file {$interfaces_file:
    template => "p/network/interfaces",
    vars     => {
      interfaces => $interfaces
    },
  } ->
  exec {'reload network':
    command => "sudo service networking stop ; sudo service networking start",
  } ->
  anchor {'p::system::network::end':
  }

}