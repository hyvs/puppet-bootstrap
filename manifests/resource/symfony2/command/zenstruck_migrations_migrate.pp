define p::resource::symfony2::command::zenstruck_migrations_migrate (
  $dir        = $name,
  $env        = undef,
  $log_append = true,
  $stdout     = undef,
  $stderr     = undef
) {

  $options = '--no-interaction'

  p::resource::symfony2::command {"${dir} zenstruck:migrations:migrate":
    command    => 'zenstruck:migrations:migrate',
    params     => "${options}",
    dir        => $dir,
    env        => $env,
    stdout     => $stdout,
    stderr     => $stderr,
    log_append => $log_append,
  }

}