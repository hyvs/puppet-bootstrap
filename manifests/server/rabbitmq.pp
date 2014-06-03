class p::server::rabbitmq (
  $admin_enabled         = false,
  $collect_stat_interval = 10000,
  $conf_file             = '/etc/rabbitmq/rabbitmq',
  $default_vhosts        = {'/' => {}},
  $dirs                  = hiera_hash('dirs'),
  $gid                   = 963,
  $group                 = 'rabbitmq',
  $firewall              = true,
  $log_levels            = '{connection, info}',
  $management_port       = 55672,
  $node_name             = "rabbit01",
  $plugin_resource       = 'p::resource::rabbitmq::plugin',
  $plugins               = hiera_hash('rabbitmq_plugins'),
  $port                  = 5672,
  $rabbitmq_home         = '/var/lib/rabbitmq',
  $rabbitmq_plugins_dir  = '/etc/rabbitmq/enabled_plugins',
  $rabbitmq_shell        = '/bin/false',
  $real_management_port  = 15672,
  $server_package        = 'rabbitmq-server',
  $uid                   = 963,
  $user                  = 'rabbitmq',
  $user_resource         = 'p::resource::rabbitmq::user',
  $users                 = hiera_hash('rabbitmq_users'),
  $version               = '3.2.3-1',
  $vhost_resource        = 'p::resource::rabbitmq::vhost',
  $vhosts                = hiera_hash('rabbitmq_vhosts')
){

  $rabbitmq_logs_dir = "${dirs['logs']}/rabbitmq"
  $real_vhosts       = merge($default_vhosts, $vhosts)
  $vhosts_defaults   = {
    require => Anchor['p::server::rabbitmq::begin'],
    before  => Anchor['p::server::rabbitmq::end']
  }
  $users_defaults    = {
    require => Anchor['p::server::rabbitmq::begin'],
    before  => Anchor['p::server::rabbitmq::end']
  }
  $plugins_defaults  = {
    require => Anchor['p::server::rabbitmq::begin'],
    before  => Anchor['p::server::rabbitmq::end']
  }

  anchor {'p::server::rabbitmq::begin': } ->
  group {$group:
    gid     => $uid,
    before  => User[$user],
    members => [$group]
  } ->
  user {$user:
    home    => $rabbitmq_home,
    shell   => $rabbitmq_shell,
    uid     => $uid,
    gid     => $gid,
  } ->
  p::resource::directory {$rabbitmq_logs_dir:
    owner   => $user,
    group   => $group,
  } ->
  class {'::rabbitmq':
    version               => $version,
    package_name          => $server_package,
    package_prefer_distro => true,
    environment_variables => {
      'NODENAME'             => $node_name,
      'CONFIG_FILE'          => $conf_file,
      'LOG_BASE'             => $rabbitmq_logs_dir,
      'ENABLED_PLUGINS_FILE' => $rabbitmq_plugins_dir
    },
    config_variables    => {
      'tcp_listeners'               => "[${port}]",
      'collect_statistics_interval' => $collect_stat_interval,
      'log_levels'                  => "[${log_levels}]"
    },
    admin_enable       => $admin_enabled,
    management_port    => $management_port,
    management_log_dir => $rabbitmq_logs_dir,
    delete_guest_user  => true,
  } ->
  p::resource::firewall::tcp {'rabbitmq_management':
    enabled => any2bool($firewall),
    port    => any2int($management_port),
  } ->
  p::resource::firewall::tcp {'rabbitmq_management_real':
    enabled => any2bool($firewall),
    port    => any2int($real_management_port),
  } ->
  anchor {'p::server::rabbitmq::end': } ->

  create_resources($vhost_resource, $vhosts, $vhosts_defaults)
  create_resources($user_resource, $users, $users_defaults)
  create_resources($plugin_resource, $plugins, $plugins_defaults)

}