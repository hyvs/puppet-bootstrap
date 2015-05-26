class p::system::network (
  $interfaces       = hiera_hash('network_interfaces'),
  $extra_interfaces = hiera_hash('extra_network_interfaces'),
  $resource         = 'p::resource::network::interface'
) {

  $interfaces_file      = "/etc/network/interfaces"
  $extra_interfaces_dir = "/etc/network/interfaces.d"

  exec { 'reload network': command => "sudo service networking restart" }

  $interfaces_count = $interfaces.reduce |$interface, $s| { $s + 1 }
  $extra_interfaces_count = $extra_interfaces.reduce |$interface, $s| { $s + 1 }

  if $interfaces_count > 0 {
    p::resource::file { $interfaces_file:
      template => "p/network/interfaces.erb",
      vars     => {interfaces => $interfaces},
      before  => Exec['reload network'],
    }
  }

  if $extra_interfaces_count > 0 {
    file_line { 'interfaces.d support enable':
      path  => $interfaces_file,
      line  => "source ${extra_interfaces_dir}/*.cfg",
      before  => Exec['reload network'],
    }

    $defaults = {
      require => File_line['interfaces.d support enable'],
      before  => Exec['reload network'],
    }

    create_resources($resource, $extra_interfaces, $defaults)
  }

}