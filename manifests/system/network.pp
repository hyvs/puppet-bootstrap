class p::system::network (
  $interfaces         = hiera_hash('network_interfaces'),
  $interface_resource = 'p::resource::netinterface'
) {

  anchor {'p::system::network::begin': }

  $defaults = {
    require => Anchor['p::system::network::begin'],
    before  => Anchor['p::system::network::reload'],
  }

  create_resources($interface_resource, $interfaces, $defaults)

  anchor {'p::system::network::reload':
    require => Anchor['p::system::network::begin'],
  } ->
  exec {'reload network':
    command => "sudo service networking stop ; sudo service networking start",
  } ->
  anchor {'p::system::network::end':
  }

}