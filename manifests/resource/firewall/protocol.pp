define p::resource::firewall::protocol (
  $enabled = true
) {

  if any2bool($enabled) and defined('::firewall') {

    $description = "Allow protocol ${name}"

    firewall { "010 ${description}":
      action => 'accept',
      proto  => $name
    }

  }

}