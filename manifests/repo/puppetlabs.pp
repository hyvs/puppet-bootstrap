class p::repo::puppetlabs (
) {

  p::resource::apt::repo { 'puppetlabs':
    location   => 'http://apt.puppetlabs.com',
    release    => 'wheezy',
    repos      => 'main',
    key        => '1054B7A24BD6EC30',
    key_server => 'http://apt.puppetlabs.com/pubkey.gpg',
  }

}