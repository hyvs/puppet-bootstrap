define p::resource::rabbitmq::vhost (
  $path = $name
) {

  rabbitmq_vhost {$path:
    ensure  => present,
    require => Class['::rabbitmq'],
  }

}