define p::resource::firewall::tcp (
  $port,
  $enabled = true
) {

  if $enabled

    firewall { "500 accept ${name} (TCP:${port})":
      action => accept,
      port   => $port,
      proto  => 'tcp'
    }

}