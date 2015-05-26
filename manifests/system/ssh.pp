class p::system::ssh (
  $knownhosts         = hiera_hash('ssh_knownhosts'),
  $firewall           = true,
  $port               = 22,
  $knownhost_resource = 'p::resource::ssh::knownhost'
) {

  p::resource::firewall::tcp { 'sshd': enabled => $firewall, port => $port }

  create_resources($knownhost_resource, $knownhosts)

}