class p::repo::newrelic (
) {

  p::resource::apt::repo { 'newrelic':
    location   => 'http://apt.newrelic.com/debian/',
    release    => 'newrelic',
    repos      => 'non-free',
    key        => 'B31B29E5548C16BF',
    key_server => 'http://keyserver.ubuntu.com/pks/lookup?op=get\\&search=0xB31B29E5548C16BF',
  }

}