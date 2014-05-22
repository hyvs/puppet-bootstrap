define p::resource::directory (
  $owner = 'root',
  $group = 'root',
  $mode  = undef
) {

  file {$name:
    ensure => 'directory',
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }

}