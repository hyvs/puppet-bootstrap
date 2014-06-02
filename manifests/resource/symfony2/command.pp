define p::resource::symfony2::command (
  $dir,
  $command     = undef,
  $params      = undef,
  $env         = undef,
  $stdout      = undef,
  $stderr      = undef,
  $blackhole   = '/dev/null',
  $php_bin     = 'php',
  $console_bin = 'app/console',
  $log_append  = true
) {

  if any2bool($log_append) {
    $operator = '>>'
  } else {
    $operator = '>'
  }
  
  if undef != $env {
    $env_options = "--env=${env}"
  } else {
    $env_options = ''
  }

  if undef != $stdout and undef != $stderr {
    if $stdout == $stderr {
      $redirect = "${operator} ${stdout} 2${operator}&1"
    } else {
      $redirect = "${operator} ${stdout} 2${operator} ${stderr}"
    }
  } else {
    if undef == $stdout {
      $redirect = "${operator} ${stdout} 2${operator} ${blackhole}"
    } else {
      $redirect = "${operator} ${blackhole} 2${operator} ${stderr}"
    }
  }

  exec {"symfony2 ${command} ${params} ${env} ${dir}" :
    cwd     => $dir,
    command => "${php_bin} ${console_bin} ${env_options} ${command} ${params} ${redirect}",
  }

}
