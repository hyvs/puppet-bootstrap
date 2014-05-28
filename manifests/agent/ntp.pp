class p::agent::ntp (
  $servers = hiera_array('ntp_servers')
) {

  anchor {'p::agent::ntp::begin': } ->
  class {'::ntp':
    server => $servers,
  } ->
  anchor {'p::agent::ntp::end': }

}