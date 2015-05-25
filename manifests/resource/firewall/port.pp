define p::resource::firewall::port (
  $port,
  $enabled = true
) {

  if $enabled and defined('::firewall') {

    $description = "Allow access to ${name} (TCP/UDP ${port})"

    firewall { "500 ${description}":
      action => accept,
      port   => $port,
      proto  => 'all'
    }

  }

}