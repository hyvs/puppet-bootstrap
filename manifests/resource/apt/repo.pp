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

  case $key {
    false: {
      $key_hash = {
        server  => $key_server,
        content => $key_content,
        source  => $key_source,
      }
    }
    default: {
      $key_hash = {
        id      => $key,
        server  => $key_server,
        content => $key_content,
        source  => $key_source,
      }
    }
  }

  $include_hash = {
    deb => true,
    src => any2bool($include_src),
  }

  apt::source {$repo:
    ensure            => $ensure,
    location          => $location,
    release           => $release,
    repos             => $repos,
    include           => $include_hash,
    key               => $key_hash,
    pin               => $pin,
    architecture      => $architecture,
  }

  create_resources($pin_resource, $pins, $pins_defaults)

}