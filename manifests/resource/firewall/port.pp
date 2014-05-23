define p::resource::firewall::port (
  $port,
  $enabled = true
) {

  if any2bool($enabled) and defined('::firewall') {

    $description = "Allow access to ${name} (TCP/UDP ${port})"

    firewall { "500 ${description}":
      action => accept,
      port   => any2int($port),
      proto  => 'all'
    }

  }

}