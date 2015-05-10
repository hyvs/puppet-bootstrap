class p::repo::nodesource (
) {

  anchor {'p::repo::nodesource::begin': } ->
  p::resource::apt::repo {'nodesource':
    location    => 'https://deb.nodesource.com',
    release     => 'node_0.12',
    repos       => 'main',
    key_server  => 'https://deb.nodesource.com/gpgkey/nodesource.gpg.key',
    pin         => 1000,
  } ->
  anchor {'p::repo::nodesource::end': }

}