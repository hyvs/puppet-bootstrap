define p::resource::link (
  $target,
  $group   = undef,
  $mode    = '0755',
  $owner   = undef,
  $replace = 'no'
) {

  file {$name:
    ensure  => link,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    target  => $target,
    replace => $replace,
  }

}