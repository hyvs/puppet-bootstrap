define p::resource::directory (
  $group        = 'root',
  $mode         = undef,
  $path         = $name,
  $owner        = 'root',
  $recurse      = false,
  $recurselimit = undef,
  $require_dir  = undef
) {

  file {$name:
    ensure       => directory,
    group        => $group,
    mode         => $mode,
    owner        => $owner,
    path         => $path,
    recurse      => $recurse,
    recurselimit => $recurselimit,
  }

  if undef != $require_dir {
    File[$require_dir] -> File[$name]
  }

}