define p::resource::netinterface (
  $ip,
  $netmask,
  $network,
  $broadcast,
  $dir,
  $comment = undef
) {

  $file = "${dir}/${name}"

  p::resource::file {$file:
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