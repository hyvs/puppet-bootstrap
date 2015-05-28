class p::system::firewall_post {

  p::resource::firewall::protocol { 'all': action => 'drop', rule_name => '999 drop all' }

}