define p::resource::apt::pin (
  $packages,
  $priority,
  $release    = undef,
  $version    = undef,
  $originator = undef
) {

  apt::pin { $name:
    packages   => $packages,
    originator => $originator,
    release    => $release,
    version    => $version,
    priority   => $priority,
  }

}