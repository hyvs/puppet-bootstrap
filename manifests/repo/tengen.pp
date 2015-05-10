class p::repo::tengen (
) {

  anchor {'p::repo::tengen::begin': } ->
  p::resource::apt::repo {'10gen':
    location    => 'http://repo.mongodb.org/apt/debian',
    release     => 'jessie/mongodb-org/3.0',
    repos       => 'main',
    key         => '7F0CEB10',
    key_server  => 'keyserver.ubuntu.com',
    pin         => 10,
    include_src => false,
  } ->
  anchor {'p::repo::tengen::end': }

}