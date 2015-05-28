class p::system::firewall_post {

  firewall { '999 (post) drop all':
    action  => 'drop',
    proto   => 'all',
    require => Class['p::system::firewall_pre'],
    before  => undef,
  }

}