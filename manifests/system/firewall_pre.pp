class p::system::firewall_pre {

     firewall { '010 (pre) accept protocol icmp':
       action => 'accept',
       proto => 'icmp',
       require => undef,
       before  => Class['p::system::firewall_post'],
     }
  -> firewall { '020 (pre) accept all on lo interface':
       action => 'accept',
       proto => 'all',
       iniface => 'lo',
       require => undef,
       before  => Class['p::system::firewall_pre'],
     }
  -> firewall { '030 (pre) accept all with state RELATED,ESTABLISHED':
       action => 'accept',
       proto => 'all',
       state => ['RELATED', 'ESTABLISHED'],
       require => undef,
       before  => Class['p::system::firewall_post'],
     }

}