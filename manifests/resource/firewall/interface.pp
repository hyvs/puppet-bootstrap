define p::resource::firewall::interface (
  $enabled = true
) {

  if $enabled and defined('::firewall') {

    $description = "Allow access to ${name} interface"

    firewall { "020 ${description}":
      action  => 'accept',
      proto   => 'all',
      iniface => $name,
    }

  }

}