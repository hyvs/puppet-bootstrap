class p::server::activemq (
  $firewall = true,
  $port     = 61613,
  $version  = '5.10.0'
) {

  anchor {'p::server::activemq::begin': } ->
  class {'::activemq':
    install_dependencies => false,
    install_source       => "http://www.eu.apache.org/dist/activemq/${version}/apache-activemq-${version}-bin.zip",
    install              => 'source',
    version              => $version,
    template             => 'mcollective/activemq.xml.erb',
  } ->
  p::resource::firewall::tcp {'activemq':
    port    => $port,
    enabled => any2bool($firewall),
  } ->
  anchor {'p::server::activemq::end':}

}