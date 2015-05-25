class p::system::firewall_post {

     anchor   { 'p::system::firewall_post::begin':                               }
  -> firewall { '999 drop all':                    proto  => all, action => drop }
  -> anchor   { 'p::system::firewall_post::end':                                 }

}