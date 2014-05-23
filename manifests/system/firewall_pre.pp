class p::system::firewall_pre {

  Firewall {
    require => undef,
  }

  anchor {'p::system::firewall_pre::begin': } ->
  p::resource::firewall::protocol {'icmp': } ->
  p::resource::firewall::interface {'lo': } ->
  p::resource::firewall::state {'RELATED,ESTABLISHED': } ->
  anchor {'p::system::firewall_pre::end': }

}