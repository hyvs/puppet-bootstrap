define p::resource::apt::repo (
  $architecture      = undef,
  $ensure            = 'present',
  $include_src       = true,
  $key               = false,
  $key_content       = false,
  $key_server        = 'keyserver.ubuntu.com',
  $key_source        = false,
  $location          = '',
  $pin               = false,
  $release           = 'UNDEF',
  $repo              = $name,
  $repos             = 'main',
  $pins              = {},
  $pin_resource      = 'p::resource::apt::pin'
) {

  $pins_defaults = {
    require => Apt::Source[$repo],
  }

  apt::source {$repo:
    ensure            => $ensure,
    location          => $location,
    release           => $release,
    repos             => $repos,
    include           => {
      deb => true,
      src => any2bool($include_src),
    },
    key               => {
      id      => $key ? { false => undef, default => $key},
      server  => $key_server,
      content => $key_content,
      source  => $key_source,
    },
    pin               => $pin,
    architecture      => $architecture,
  }

  create_resources($pin_resource, $pins, $pins_defaults)

}