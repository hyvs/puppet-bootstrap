define p::resource::symfony2::command::assets_install (
  $dir        = $name,
  $env        = undef,
  $log_append = true,
  $mode       = 'symlink',
  $stdout      = undef,
  $stderr      = undef
) {

  if 'symlink' == $mode {
    $mode_options = '--symlink'
  } else {
    $mode_options = ''
  }

  p::resource::symfony2::command {"${dir} assets:install":
    command    => 'assets:install',
    params     => "${mode_options}",
    dir        => $dir,
    env        => $env,
    stdout     => $stdout,
    stderr     => $stderr,
    log_append => $log_append,
  }

}
