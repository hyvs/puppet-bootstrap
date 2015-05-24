define p::resource::firewall::state (
  $enabled = true
) {

  if $enabled and defined('::firewall') {

    $description = "Allow access to ${name} state(s)"

    firewall { "030 ${description}":
      action => 'accept',
      proto  => 'all',
      state  => split($name, ','),
    }

  }

}