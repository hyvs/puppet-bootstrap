class p::system::firewall_pre {

  Firewall {
    require => undef,
    before  => Class['p::system::firewall_post'],
  }

     firewall { '010 (pre) accept protocol icmp':
       action => 'accept',
       proto => 'icmp',
     }
  -> firewall { '020 (pre) accept all on lo interface':
       action => 'accept',
       proto => 'all',
       iniface => 'lo',
     }
  -> firewall { '030 (pre) accept all with state RELATED,ESTABLISHED':
       action => 'accept',
       proto => 'all',
       state => ['RELATED', 'ESTABLISHED'],
     }

}