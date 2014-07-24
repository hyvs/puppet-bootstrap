class p::repo::dotdeb_php55 (
) {

  anchor {'p::repo::dotdeb_php55::begin': } ->
  p::resource::apt::repo {'dotdeb_php55':
    location    => 'http://packages.dotdeb.org',
    release     => 'wheezy-php55',
    repos       => 'all',
    pin         => 1000,
  } ->
  anchor {'p::repo::dotdeb_php55::end': }

}