define p::resource::firewall::interface (
  $enabled = true
) {

  if $enabled

    firewall { "120 accept all on ${name} interface":
      action  => 'accept',
      proto   => 'all',
      iniface => $name,
    }

}