class p::repo::dotdeb (
) {

  p::resource::apt::repo { 'dotdeb':
    location   => 'http://packages.dotdeb.org',
    release    => 'jessie',
    repos      => 'all',
    key        => '7E3F070089DF5277',
    key_server => 'http://www.dotdeb.org/dotdeb.gpg',
  }

}