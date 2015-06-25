class p::repo::nginx (
) {

  p::resource::apt::repo { 'nginx':
    location   => 'http://nginx.org/packages/debian/',
    release    => 'jessie',
    repos      => 'nginx',
    key_server => 'http://nginx.org/keys/nginx_signing.key',
  }

}