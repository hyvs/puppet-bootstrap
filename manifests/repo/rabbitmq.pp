class p::repo::rabbitmq (
) {

  anchor {'p::repo::rabbitmq::begin': } ->
  p::resource::apt::repo {'rabbitmq':
    location    => 'http://www.rabbitmq.com/debian',
    release     => 'testing',
    repos       => 'main',
    key         => '056E8E56',
    key_source  => 'pgp.mit.edu',
  } ->
  anchor {'p::repo::rabbitmq::end': }

}