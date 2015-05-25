define p::resource::firewall::tcp (
  $port,
  $enabled = true
) {

  if $enabled and defined('::firewall') {

    $description = "Allow access to ${name} (TCP ${port})"

    firewall { "500 ${description}":
      action => accept,
      port   => $port,
      proto  => 'tcp'
    }

  }

}