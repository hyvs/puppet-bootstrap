class p::repo::nodesource (
) {

  p::resource::apt::repo { 'nodesource':
    location   => 'https://deb.nodesource.com',
    release    => 'node_0.12',
    repos      => 'main',
    key        => '1655A0AB68576280',
    key_server => 'https://deb.nodesource.com/gpgkey/nodesource.gpg.key',
  }

}