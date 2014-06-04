define p::resource::backup::cron (
  $template,
  $agent_user,
  $script_dir,
  $script_prefix = 'backup-',
  $options       = undef,
  $user          = 'root',
  $date          = '*',
  $hour          = '*',
  $minute        = '*',
  $month         = '*',
  $weekday       = '*'
) {

  $shell_file   = "${script_dir}/${script_prefix}${name}"

  $forced_options = {frequency => "${minute} ${hour} ${date} ${month} ${weekday}"}

  if is_hash($options) {
    $real_options = merge($options, $forced_options)
  } else {
    $real_options = $forced_options
  }

  p::resource::file {$shell_file:
    template => $template,
    vars     => $real_options,
  }

  p::resource::cron {"${script_prefix}${name}":
    command => "sh ${shell_file}"
    date    => $date,
    hour    => $hour,
    minute  => $minute,
    month   => $month,
    user    => $user,
    weekday => $weekday,
  }

}
