define p::resource::firewall::udp (
  $port,
  $enabled = true
) {

  if $enabled

    firewall { "500 accept ${name} (UDP:${port})":
      action => accept,
      port   => $port,
      proto  => 'udp'
    }

}