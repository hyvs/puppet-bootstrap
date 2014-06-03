class p::repo::varnish (
) {

  anchor {'p::repo::varnish::begin': } ->
  p::resource::apt::repo {'varnish':
    location    => 'http://repo.varnish-cache.org/debian',
    repos       => 'varnish-3.0',
    key         => 'C4DEFFEB',
    key_source  => 'http://repo.varnish-cache.org/debian/GPG-key.txt',
  } ->
  anchor {'p::repo::varnish::end': }

}