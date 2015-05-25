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

  $real_environment = join_keys_to_values(merge($default_environment, $environment), '=')

  if !defined(Package['cron']) {
    package { 'cron':
      ensure => 'installed',
    }
  }

  file { "/etc/cron.d/${title}":
    ensure  => 'present',
    content => template( 'p/cron/job.erb' ),
    require => Package['cron'],
  }

}