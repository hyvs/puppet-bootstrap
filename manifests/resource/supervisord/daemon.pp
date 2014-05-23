define p::resource::supervisord::daemon (
  $command,
  $log_dir,
  $conf_dir           = '/etc/supervisor/conf.d',
  $conf_group         = 'root',
  $conf_owner         = 'root',
  $conf_template      = 'p/supervisord/program.conf.erb',
  $daemon             = $name,
  $stderr             = undef,
  $stderr_file_suffix = 'stderr',
  $stdout             = undef,
  $stdout_file_suffix = 'stdout',
  $tool_package       = 'supervisor',
  $user               = 'root'
) {

  $conf_file = "${conf_dir}/${daemon}.conf"

  if undef == $stdout {
    $stdout_file = "${log_dir}/${daemon}-${stdout_file_suffix}.log"
  } else {
    $stdout_file = $stdout
  }

  if undef == $stderr {
    $stderr_file = "${log_dir}/${daemon}-${stderr_file_suffix}.log"
  } else {
    $stderr_file = $stderr
  }

  file {$conf_file:
    ensure  => file,
    content => template($conf_template),
    group   => $conf_group,
    owner   => $conf_owner,
    require => Package[$tool_package],
  }

}