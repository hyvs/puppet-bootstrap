class p::agent::ntp (
  $servers  = hiera_array('ntp_servers'),
  $restrict = ['127.0.0.1']
) {

  anchor {'p::agent::ntp::begin': }

  class { '::ntp':
    servers  => $servers,
    restrict => $restrict,
    require => Anchor['p::agent::ntp::begin'],
    before  => Anchor['p::agent::ntp::end'],
  }

  anchor {'p::agent::ntp::end':
    require => Anchor['p::agent::ntp::begin'],
  }

}