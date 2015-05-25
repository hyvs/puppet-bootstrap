class p::system::network (
  $interfaces       = hiera_hash('network_interfaces'),
  $extra_interfaces = hiera_hash('extra_network_interfaces'),
  $resource         = 'p::resource::network::interface'
) {

  $interfaces_file      = "/etc/network/interfaces"
  $extra_interfaces_dir = "/etc/network/interfaces.d"

     anchor { 'p::system::network::begin':  }
  -> anchor { 'p::system::network::reload': }
  -> exec   { 'reload network':             command => "sudo service networking restart" }
  -> anchor { 'p::system::network::end':    }

  if !empty($interfaces) {
    if !$interfaces['lo'] {
      fail("No lo interfaces defined")
    }

    if !$interfaces['eth0'] {
      fail("No eth0 interfaces defined")
    }

    p::resource::file {$interfaces_file:
      template => "p/network/interfaces.erb",
      vars     => {
        interfaces => $interfaces
      },
      require => Anchor['p::system::network::begin'],
      before  => Anchor['p::system::network::reload'],
    }
  }

  if !empty($extra_interfaces) {
    file_line { 'interfaces.d support enable':
      path  => $interfaces_file,
      line  => "source ${extra_interfaces_dir}/*.cfg",
      require => Anchor['p::system::network::begin'],
      before  => Anchor['p::system::network::reload'],
    }

    $defaults = {
      require => File_line['interfaces.d support enable'],
      before  => Anchor['p::system::network::reload'],
    }

    create_resources($resource, $extra_interfaces, $defaults)
  }

}