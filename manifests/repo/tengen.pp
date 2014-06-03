class p::repo::tengen (
) {

  anchor {'p::repo::10gen::begin': } ->
  p::resource::apt::repo {'10gen':
    location    => 'http://downloads-distro.mongodb.org/repo/debian-sysvinit',
    release     => 'dist',
    repos       => '10gen',
    key         => '7F0CEB10',
    key_server  => 'keyserver.ubuntu.com',
    pin         => 10,
    include_src => false,
  } ->
  anchor {'p::repo::10gen::end': }

}