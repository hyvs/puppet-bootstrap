define p::resource::cron (
  $command,
  $date                = '*',
  $default_environment = {},
  $environment         = {},
  $hour                = '*',
  $minute              = '*',
  $month               = '*',
  $user                = 'root',
  $weekday             = '*'
) {

  if !is_array($command) {
    $real_command = $command
  } else {
    $real_command = join($command, ' && ')
  }

  cron::job {$name:
    minute      => $minute,
    hour        => $hour,
    date        => $date,
    month       => $month,
    weekday     => $weekday,
    user        => $user,
    command     => $real_command,
    environment => join_keys_to_values(merge($default_environment, $environment), '='),
  }

}