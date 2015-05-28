class p::system::firewall_post {

  Firewall {
    require => Class['p::system::firewall_pre'],
    before  => undef,
  }

  firewall { '999 (post) drop all':
    action  => 'drop',
    proto   => 'all',
  }

}