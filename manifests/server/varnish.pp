class p::server::varnish (
  $acls           = hiera_array('varnish_acls'),
  $admin_ip       = '127.0.0.1',
  $admin_port     = 6082,
  $backends       = hiera_array('varnish_backends'),
  $conditions     = hiera_array('varnish_conditions'),
  $directors      = hiera_array('varnish_directors'),
  $dirs           = hiera_hash('dirs'),
  $firewall       = true,
  $ip             = undef,
  $max_threads    = 500,
  $min_threads    = 5,
  $port           = 80,
  $probes         = hiera_array('varnish_probes'),
  $selectors      = hiera_array('varnish_selectors'),
  $storage_size   = '1G',
  $thread_timeout = 300,
  $ttl            = 120,
  $version        = 'present'
) {

  anchor {'p::server::varnish::begin': } ->
  class {'::varnish':
    start                        => true,
    varnish_admin_listen_address => $admin_ip,
    varnish_admin_listen_port    => any2int($admin_port),
    varnish_listen_address       => $ip,
    varnish_listen_port          => any2int($port),
    varnish_min_threads          => any2int($min_thread),
    varnish_max_threads          => any2int($max_thread),
    varnish_storage_size         => $storage_size,
    varnish_thread_timeout       => any2int($thread_timeout),
    varnish_ttl                  => any2int($ttl),
    version                      => $version,
  } ->
  class {'::varnish::vcl':
    acls       => $acls,
    backends   => $backends,
    conditions => $conditions,
    directors  => $directors,
    probes     => $probes,
    selectors  => $selectors,
  } ->
  p::resource::firewall::tcp {'varnish':
    enabled => any2bool($firewall),
    port    => any2int($port),
  } ->
  anchor {'p::server::varnish::end': }

}