class p::repo::puppetlabs (
) {

  p::resource::apt::repo { 'puppetlabs-pc1':
    location   => 'http://apt.puppetlabs.com',
    release    => 'wheezy',
    repos      => 'PC1',
    key        => '1054B7A24BD6EC30',
    key_server => 'http://apt.puppetlabs.com/pubkey.gpg',
  }

}