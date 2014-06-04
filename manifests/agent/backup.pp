class p::agent::backup (
  $dirs  = hiera_hash('dirs'),
  $crons = hiera_hash('backup_crons'),
  $agent_user      = "backupagent",
  $agent_user_home = undef,
  $script_prefix   = "backup-",
  $script_dir      = undef,
  $cron_resource   = 'p::resource::backup::cron'
) {

  if undef == $agent_user_home {
    $real_agent_user_home = "/home/${agent_user}"
  } else {
    $real_agent_user_home = $agent_user_home
  }

  if undef == $script_dir {
    $full_script_dir = "${real_agent_user_home}/bin"
  } else {
    $full_script_dir = $script_dir
  }

  $backup_dir = $dirs['backups']

  $crons_defaults = {
    require => Anchor['p::agent::backup::crons'],
    before  => Anchor['p::agent::backup::end'],
    agent_user => $agent_user,
    script_dir => $full_script_dir,
    script_prefix => $script_prefix
  }

  p::resource::package {'nfs-common':
    require => Anchor['p::agent::backup::begin'],
    before  => Anchor['p::agent::backup::crons'],
  }

  file {$backup_dir:
    ensure => directory,
    require => Anchor['p::agent::backup::begin'],
    before  => Anchor['p::agent::backup::crons'],
  }

  p::resource::user {$agent_user:
    home    => $agent_user_home,
    require => Anchor['p::agent::backup::begin'],
  } ->
  p::resource::directory {$full_script_dir:
    owner   => $agent_user,
    group   => 'root',
    mode    => '0700',
    recurse => true,
    before  => Anchor['p::agent::backup::crons'],
  }

  create_resources($cron_resource, $crons, $crons_defaults)

  anchor {'p::agent::backup::begin': } ->
  anchor {'p::agent::backup::crons': } ->
  anchor {'p::agent::backup::end':   }

}