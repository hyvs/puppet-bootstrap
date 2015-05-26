class p::system::firewall_pre {

  Firewall { require => undef }

     p::resource::firewall::protocol  { 'icmp':                }
  -> p::resource::firewall::interface { 'lo':                  }
  -> p::resource::firewall::state     { 'RELATED,ESTABLISHED': }

}