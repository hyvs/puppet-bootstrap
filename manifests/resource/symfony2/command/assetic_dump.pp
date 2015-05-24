define p::resource::symfony2::command::assetic_dump (
  $dir        = $name,
  $env        = undef,
  $log_append = true,
  $force      = true,
  $stdout     = undef,
  $stderr     = undef
) {

  if $force {
    $options = '--force'
  } else {
    $options = ''
  }

  p::resource::symfony2::command {"${dir} assetic:dump":
    command    => 'assetic:dump',
    params     => "${options}",
    dir        => $dir,
    env        => $env,
    stdout     => $stdout,
    stderr     => $stderr,
    log_append => $log_append,
  }

}
