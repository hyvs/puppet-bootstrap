class p::repo::dotdeb_php55 (
) {

  anchor {'p::repo::dotdeb_php55::begin': } ->
  p::resource::apt::repo {'dotdeb':
    location    => 'http://packages.dotdeb.org',
    release     => 'wheezy-php55',
    repos       => 'all',
    key         => '89DF5277',
    key_server  => 'http://www.dotdeb.org/dotdeb.gpg',
    pin         => 1000,
  } ->
  anchor {'p::repo::dotdeb_php55::end': }

}