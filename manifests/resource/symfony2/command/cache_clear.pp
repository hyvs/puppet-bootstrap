define p::resource::symfony2::command::cache_clear (
  $dir        = $name,
  $env        = undef,
  $log_append = true,
  $stdout     = undef,
  $stderr     = undef
) {

  p::resource::symfony2::command {"${dir} cache:clear":
    command    => 'cache:clear',
    dir        => $dir,
    env        => $env,
    log_append => $log_append,
    stderr     => $stderr,
    stdout     => $stdout,
  }

}
