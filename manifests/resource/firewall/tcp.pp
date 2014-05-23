define p::resource::firewall::tcp (
  $port,
  $enabled = true
) {

  if any2bool($enabled) and defined('::firewall') {

    $description = "Allow access to ${name} (TCP ${port})"

    firewall { "500 ${description}":
      action => accept,
      port   => any2int($port),
      proto  => 'tcp'
    }

  }

}