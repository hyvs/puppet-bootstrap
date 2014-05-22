define p::resource::link (
  $target,
  $owner = 'root',
  $group = 'root',
  $mode  = undef
) {

  file {$name:
    ensure => 'link',
    owner  => $owner,
    group  => $group,
    mode   => $mode,
    target => $target,
  }

}