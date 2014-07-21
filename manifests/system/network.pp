class p::system::network (
  $interfaces         = hiera_hash('network_interfaces'),
  $interface_resource = 'p::resource::netinterface'
) {

  $interface_main_file = "/etc/network/interfaces"
  $interface_dir       = "/etc/network/interfaces.d"

  anchor {'p::system::network::begin': } ->
  p::resource::directory {$interface_dir: } ->
  file_line { "${interface_dir} source-directory":
    line => "source-directory ${interface_dir}",
    path => $interface_main_file,
  } ->
  anchor {'p::system::network::init': }

  $defaults = {
    require => Anchor['p::system::network::init'],
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