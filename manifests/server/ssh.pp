class p::server::ssh (
  $firewall = true,
  $port     = 22
) {

  if !defined(P::Resource::Firewall::Tcp['sshd']) {
    p::resource::firewall::tcp { 'sshd':
      enabled => $firewall,
      port    => $port,
      require => Anchor['p::server::ssh::begin'],
      before  => Anchor['p::server::ssh::end'],
    }
  }

     anchor               { 'p::server::ssh::begin': }
  -> p::resource::package { 'openssh-server':        }
  -> anchor               { 'p::server::ssh::end':   }

}