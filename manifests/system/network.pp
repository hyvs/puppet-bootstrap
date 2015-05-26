class p::system::network (
  $extra_interfaces = hiera_hash('extra_network_interfaces'),
  $resource         = 'p::resource::network::interface'
) {

  $interfaces_file      = "/etc/network/interfaces"
  $extra_interfaces_dir = "/etc/network/interfaces.d"

  exec { 'reload network': command => "sudo service networking restart" }

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