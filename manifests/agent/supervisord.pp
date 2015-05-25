class p::agent::supervisord (
  $daemons         = hiera_hash('daemons'),
  $daemon_resource = 'p::resource::supervisord::daemon',
  $start_command   = 'sudo supervisorctl reload && sudo supervisorctl restart all && (sudo service supervisor stop ; sudo service supervisor start)',
  $restart_command = 'sudo supervisorctl reload && sudo supervisorctl restart all && (sudo service supervisor stop ; sudo service supervisor start)',
  $stop_command    = 'sudo supervisorctl reload && sudo supervisorctl stop all && (sudo service supervisor stop ; sudo service supervisor start)',
  $status_command  = 'test `sudo ps -aef | grep supervisorctl | wc -l` -gt 1',
  $log_dir         = '/var/log/supervisord'
) {

  $daemons_defaults = {
    log_dir      => $log_dir,
    tool_package => 'supervisor',
    notify       => Service['supervisorctl'],
    require      => P::Resource::Directory[$log_dir],
    before       => Service['supervisorctl'],
  }

     anchor                 { 'p::agent::supervisord::begin':    }
  -> p::resource::package   { 'supervisor':                      }
  -> p::resource::directory { $log_dir:        mode    => '0777' }
  -> service                { 'supervisorctl': ensure  => 'running', start => $start_command, restart => $restart_command, stop => $stop_command, status => $status_command }
  -> anchor                 { 'p::agent::supervisord::end':      }

  create_resources($daemon_resource, $daemons, $daemons_defaults)

}
