class p::server::mysql (
  $innodb_buffer_pool_size         = '512M',
  $socket                          = '/var/run/mysqld/mysqld.sock',
  $bind_address                    = '127.0.0.1',
  $port                            = '3306',
  $datadir                         = '/var/lib/mysql',
  $expire_logs_days                = '4',
  $concurrent_insert               = '2',
  $innodb_additional_mem_pool_size = '64M',
  $innodb_data_file_path           = 'ibdata1:18M:autoextend',
  $innodb_file_per_table           = true,
  $innodb_flush_log_at_trx_commit  = '2',
  $innodb_flush_method             = 'O_DIRECT',
  $innodb_lock_wait_timeout        = '400',
  $innodb_log_buffer_size          = '8M',
  $innodb_log_file_size            = '64M',
  $innodb_thread_concurrency       = '16',
  $join_buffer_size                = '2M',
  $key_buffer                      = '128M',
  $low_priority_updates            = '1',
  $max_allowed_packet              = '16M',
  $max_connections                 = '400',
  $max_heap_table_size             = '256M',
  $myisam_sort_buffer_size         = '64M',
  $query_cache_limit               = '1M',
  $query_cache_size                = '128M',
  $read_buffer_size                = '1024K',
  $read_rnd_buffer_size            = '4096K',
  $skip_external_locking           = true,
  $skip_name_resolve               = false,
  $skip_ssl_template               = 'p/mysql/skip_ssl.cnf.erb',
  $skip_ssl_conf_file              = '/etc/mysql/conf.d/skip_ssl.cnf',
  $sort_buffer_size                = '1024K',
  $table_cache                     = '256',
  $thread_cache_size               = '8',
  $thread_concurrency              = '8',
  $thread_stack                    = '128K',
  $tmp_table_size                  = '512M',
  $transaction_isolation           = 'READ-COMMITTED',
  $wait_timeout                    = '60',
  $packages                        = hiera_array('mysql_packages', ['percona-toolkit']),
  $dirs                            = hiera_hash('dirs'),
  $databases                       = hiera_hash('mysql_databases'),
  $database_resource               = 'p::resource::mysql::database',
  $log_error_filename              = 'errors.log',
  $user_resource                   = 'p::resource::mysql::user',
  $firewall                        = false,
  $secrets                         = hiera_hash('secrets')
) {

  if !defined(Class['p::repo::dotdeb']) {
    class {'p::repo::dotdeb': }
  }

  $default_user_password = $secrets['mysql.user.password.default']
  $root_password      = $secrets['mysql.root.password']
  $logs_dir           = $dirs['logs']
  $mysql_logs_dir     = "${logs_dir}/mysql"
  $tmpdir             = $dirs['tmp']
  $log_error          = "${mysql_logs_dir}/${log_error_filename}"
  $databases_defaults = {
    user_resource => $user_resource,
    default_user_password => $default_user_password,
    require       => Anchor['p::server::mysql::begin'],
    before        => Anchor['p::server::mysql::end'],
  }

  anchor {'p::server::mysql::begin': } ->
  anchor {'p::server::mysql::end': }

  p::resource::package {$packages:
    ensure  => installed,
    require => Anchor['p::server::mysql::begin'],
    before  => Anchor['p::server::mysql::end'],
  }

  p::resource::directory {$mysql_logs_dir:
    group   => 'adm',
    owner   => 'mysql',
    require => Anchor['p::server::mysql::begin'],
    before  => Anchor['p::server::mysql::end'],
  }

  class {'::mysql::server':
    root_password    => $root_password,
    override_options => {
      mysqld => {
        bind_address                    => $bind_address,
        datadir                         => $datadir,
        log_error                       => $log_error,
        expire_logs_days                => $expire_logs_days,
        concurrent_insert               => $concurrent_insert,
        innodb_additional_mem_pool_size => $innodb_additional_mem_pool_size,
        innodb_buffer_pool_size         => $innodb_buffer_pool_size,
        innodb_data_file_path           => $innodb_data_file_path,
        innodb_file_per_table           => $innodb_file_per_table,
        innodb_flush_log_at_trx_commit  => $innodb_flush_log_at_trx_commit,
        innodb_flush_method             => $innodb_flush_method,
        innodb_lock_wait_timeout        => $innodb_lock_wait_timeout,
        innodb_log_buffer_size          => $innodb_log_buffer_size,
        innodb_log_file_size            => $innodb_log_file_size,
        innodb_thread_concurrency       => $innodb_thread_concurrency,
        join_buffer_size                => $join_buffer_size,
        key_buffer                      => $key_buffer,
        low_priority_updates            => $low_priority_updates,
        max_allowed_packet              => $max_allowed_packet,
        max_connections                 => $max_connections,
        max_heap_table_size             => $max_heap_table_size,
        myisam_sort_buffer_size         => $myisam_sort_buffer_size,
        query_cache_limit               => $query_cache_limit,
        query_cache_size                => $query_cache_size,
        read_buffer_size                => $read_buffer_size,
        read_rnd_buffer_size            => $read_rnd_buffer_size,
        'skip-external-locking'         => $skip_external_locking,
        'skip-name-resolve'             => $skip_name_resolve,
        sort_buffer_size                => $sort_buffer_size,
        table_cache                     => $table_cache,
        thread_cache_size               => $thread_cache_size,
        thread_concurrency              => $thread_concurrency,
        thread_stack                    => $thread_stack,
        tmp_table_size                  => $tmp_table_size,
        tmpdir                          => $tmpdir,
        'transaction-isolation'         => $transaction_isolation,
        wait_timeout                    => $wait_timeout,
      },
      mysqld_safe => {
        log_error => $log_error,
      },
    },
    require => Anchor['p::server::mysql::begin'],
    before  => Anchor['p::server::mysql::end'],
  } ->
  exec {'clear_old_mysql_log':
    command => 'rm -rf /var/log/mysql; rm -rf /var/log/mysql.*',
    unless  => 'test ! -d /var/log/mysql',
    require => Anchor['p::server::mysql::begin'],
    before  => Anchor['p::server::mysql::end'],
  }

  file {$skip_ssl_conf_file:
    owner    => 'root',
    group    => 'root',
    mode     => '0644',
    content  => template($skip_ssl_template),
    require  => [File['/etc/mysql/conf.d'], Anchor['p::server::mysql::begin']],
    before   => Anchor['p::server::mysql::end'],
  }

  class {'::mysql::server::mysqltuner':
    require => Anchor['p::server::mysql::begin'],
    before  => Anchor['p::server::mysql::end'],
  }

  create_resources($database_resource, $databases, $databases_defaults)

  p::resource::firewall::tcp {'mysql':
    enabled => any2bool($firewall),
    port    => any2int($port),
    require => Anchor['p::server::mysql::begin'],
    before  => Anchor['p::server::mysql::end'],
  }

}