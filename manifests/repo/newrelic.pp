class p::repo::newrelic (
) {

  anchor {'p::repo::newrelic::begin': } ->
  p::resource::apt::repo {'newrelic':
    location    => 'http://apt.newrelic.com/debian/',
    release     => 'newrelic',
    repos       => 'non-free',
    key         => 'B31B29E5548C16BF',
    key_server  => 'hkp://subkeys.pgp.net',
    include_src => false,
  } ->
  anchor {'p::repo::newrelic::end': }

}