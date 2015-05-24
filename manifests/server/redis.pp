class p::server::redis (
  $conf_template = 'p/redis/redis.conf.erb',
  $dirs          = hiera_hash('dirs'),
  $gid           = 980,
  $group         = 'redis',
  $ip            = '127.0.0.1',
  $log_level     = 'NOTICE',
  $pidfile       = '/var/run/redis.pid',
  $port          = 6379,
  $uid           = 980,
  $user          = 'redis',
  $firewall      = false,
  $maxmemory     = undef,
  $maxmemory_policy = undef,
  $databases     = '16'
) {

  $redis_logs_dir = "${dirs['logs']}/redis"
  $redis_home     = "/var/lib/redis"
  $redis_log_file = "${redis_logs_dir}/redis-server.log"

  anchor {'p::server::redis::begin': } ->
  group {$group:
    gid     => $gid,
    members => [$group]
  } ->
  user {$user:
    home    => "/home/${user}",
    shell   => '/bin/false',
    uid     => $uid,
    gid     => $gid,
  } ->
  p::resource::directory {$redis_logs_dir:
    owner   => $user,
    group   => $group,
  } ->
  p::resource::directory {$redis_home:
    owner   => $user,
    group   => $group,
  } ->
  class {'::redis':
    template => $conf_template,
    options  => {
      bind      => $ip,
      port      => $port,
      pidfile   => $pidfile,
      loglevel  => $log_level,
      logfile   => $redis_log_file,
      datadir   => $redis_home,
      maxmemory         => $maxmemory,
      databases         => $databases,
      maxmemory_policy  => $maxmemory_policy,
    },
  } ->
  p::resource::firewall::tcp {'redis':
    enabled => $firewall,
    port    => any2int($port),
  } ->
  anchor {'p::server::redis::end': }

}