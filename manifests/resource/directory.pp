define p::resource::directory (
  $group        = 'root',
  $mode         = '0755',
  $path         = $name,
  $owner        = 'root',
  $recurse      = false,
  $recurselimit = undef
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

}