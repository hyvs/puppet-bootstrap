define p::resource::memcached::instance (
  $log_dir,
  $port,
  $connections = 1024,
  $ip          = false,
  $items_size  = '1m',
  $size        = 64
) {

  memcached::config {$name:
    connections => $connections,
    dir_log     => $log_dir,
    items_size  => $items_size,
    listen      => $ip,
    memory      => $size,
    port        => $port,
  }

}