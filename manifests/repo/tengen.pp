class p::repo::tengen (
) {

  p::resource::apt::repo { '10gen':
    location    => 'http://repo.mongodb.org/apt/debian',
    release     => 'wheezy/mongodb-org/3.0',
    repos       => 'main',
    key         => '9ECBEC467F0CEB10',
    key_server  => 'http://docs.mongodb.org/10gen-gpg-key.asc',
  }

}