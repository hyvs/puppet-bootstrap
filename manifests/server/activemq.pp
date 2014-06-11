class p::server::activemq (
  $firewall = true,
  $port     = 61613,
  $version  = '5.10.0'
) {

  anchor {'p::server::activemq::begin': } ->
  class {'::activemq':
    install_dependencies => false,
    install              => 'package',
    template             => 'mcollective/activemq.xml.erb',
    config_file          => '/etc/activemq/instances-enabled/main/activemq.xml',
  } ->
  p::resource::directory {'/var/lib/activemq/main':
  } ->
  p::resource::directory {'/var/lib/activemq/main/conf':
  } ->
  p::resource::file {'/var/lib/activemq/main/conf/credentials.properties':
    content => "activemq.username=system\nactivemq.password=manager\nguest.password=password"
  } ->
  p::resource::file {'/etc/activemq/instances-enabled/main/jetty.xml':
    content => template('p/activemq/jetty.xml.erb'),
  } ->
  p::resource::firewall::tcp {'activemq':
    port    => $port,
    enabled => any2bool($firewall),
  } ->
  anchor {'p::server::activemq::end':}

}