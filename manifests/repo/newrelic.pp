class p::repo::newrelic (
) {

  p::resource::apt::repo { 'newrelic':
    location   => 'http://apt.newrelic.com/debian/',
    release    => 'newrelic',
    repos      => 'non-free',
    key        => 'B31B29E5548C16BF',
    key_server => 'https://download.newrelic.com/548C16BF.gpg',
  }

}