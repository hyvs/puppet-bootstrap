class p::system::ssh (
  $firewall = true,
  $port     = 22,
  $knownhost_resource = 'p::resource::ssh::knownhost',
  $knownhosts         = hiera_hash('ssh_knownhosts')
) {

  $knownhosts_defaults = {
    require => Anchor['p::system::ssh::begin'],
    before  => Anchor['p::system::ssh::end']
  }

  anchor {'p::system::ssh::begin': } ->
  p::resource::firewall::tcp {'sshd':
    enabled => $firewall,
    port    => $port,
  } ->
  anchor {'p::system::ssh::end': }

  create_resources($knownhost_resource, $knownhosts, $knownhosts_defaults)

}