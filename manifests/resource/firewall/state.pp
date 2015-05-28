define p::resource::firewall::state (
  $enabled = true
) {

  if $enabled

    firewall { "130 accept all with state ${name}":
      action => 'accept',
      proto  => 'all',
      state  => split($name, ','),
    }

}