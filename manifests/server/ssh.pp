class p::server::ssh (
  $firewall = true,
  $port     = 22
) {

  if !defined(P::Resource::Firewall::Tcp['sshd']) {
    p::resource::firewall::tcp { 'sshd':
      enabled => $firewall,
      port    => $port,
    }
  }

  p::resource::package { 'openssh-server': }

}