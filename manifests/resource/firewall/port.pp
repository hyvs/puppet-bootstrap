define p::resource::firewall::port (
  $port,
  $enabled = true
) {

  if $enabled {

    firewall { "500 accept ${name} (TCP/UDP:${port})":
      action => accept,
      port   => $port,
      proto  => 'all'
    }

  }

}