define p::resource::firewall::protocol (
  $enabled   = true,
  $action    = 'accept'
) {

  if $enabled

    firewall { "110 ${action} protocol ${name}":
      action => $action,
      proto  => $name
    }

}