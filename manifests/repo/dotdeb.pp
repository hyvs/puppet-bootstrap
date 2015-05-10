class p::repo::dotdeb (
) {

  anchor {'p::repo::dotdeb::begin': } ->
  p::resource::apt::repo {'dotdeb':
    location    => 'http://packages.dotdeb.org',
    release     => 'jessie',
    repos       => 'all',
    key         => '89DF5277',
    key_server  => 'http://www.dotdeb.org/dotdeb.gpg',
    pin         => 1000,
  } ->
  anchor {'p::repo::dotdeb::end': }

}