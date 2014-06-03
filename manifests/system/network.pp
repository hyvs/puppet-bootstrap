class p::system::network (
) {

  anchor {'p::system::network::begin': } ->
  augeas { 'net.ipv4 tuning':
    context => "/files/etc/sysctl.conf",
    changes => [
    #"set <key> <value>"
    ],
  } ->
  anchor {'p::system::network::end': }

}