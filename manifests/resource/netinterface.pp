define p::resource::netinterface (
  $ip,
  $netmask,
  $network,
  $broadcast,
  $comment = undef
) {

  $interface_main_file = "/etc/network/interfaces"
  $interface_dir       = "/etc/network/interfaces.d"
  $interface_file      = "${interface_dir}/${name}"

  p::resource::directory {$interface_dir:
  } ->
  file_line { "${interface_dir} source-directory":
    line => 'source-directory interfaces.d',
    path => $interface_main_file,
  } ->
  p::resource::file {$interface_file:
    template => 'p/network/interface.erb',
    vars     => {
      name      => $name,
      ip        => $ip,
      netmask   => $netmask,
      network   => $network,
      broadcast => $broadcast,
      comment   => $comment
    },
  }

}