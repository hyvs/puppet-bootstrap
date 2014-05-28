class p::server::postfix (
  $relay_host            = undef,
  $map_resource          = 'p::resource::postfix::map',
  $sender_canonical_maps = hiera_hash('postfix_sender_canonical_maps'),
  $canonical_maps        = hiera_hash('postfix_canonical_maps'),
  $maps                  = hiera_hash('postfix_maps')
) {

  $maps_defaults = {
    require => Anchor['p::server::postfix::begin'],
    before  => Anchor['p::server::postfix::maps'],
  }

  anchor {'p::server::postfix::begin': } ->
  class {'::postfix': } ->
  anchor {'p::server::postfix::maps': } ->
  anchor {'p::server::postfix::end': }

  create_resources($map_resource, {"sender_canonical" => $sender_canonical_maps}, $maps_defaults)
  create_resources($map_resource, {"canonical"        => $canonical_maps},        $maps_defaults)
  create_resources($map_resource, $maps,                                          $maps_defaults)

  if $relay_host {
    augeas {'smtp relay host':
      changes => [
        "set /files/etc/postfix/main.cf/relayhost ${relay_host}",
      ],
      notify  => Service['postfix'],
      require => Package['postfix'],
      before  => Anchor['p::server::postfix::maps'],
    }
  }

  augeas {'smtp relay settings':
    changes => [
      "set /files/etc/postfix/main.cf/sender_canonical_maps hash:/etc/postfix/sender_canonical",
      "set /files/etc/postfix/main.cf/canonical_maps hash:/etc/postfix/canonical",
    ],
    notify  => Service['postfix'],
    require => Package['postfix'],
    before  => Anchor['p::server::postfix::maps'],
  }

}