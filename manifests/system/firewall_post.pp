class p::system::firewall_post {

  firewall { '999 drop all': proto => all, action => drop }

}