class p::server::mcollective (
  $plugin_resource = 'p::resource::mcollective::plugin',
  $stomp_version   = '1.2.2',
  $stomp_host      = hiera('mcollective_middleware', 'localhost'),
  $plugins         = hiera_hash('mcollective_plugins'),
  $secrets         = hiera_hash('secrets')
) {

  $plugins_defaults = {
  }

  $stomp_password = $secrets['stomp.password']
  $stomp_psk      = $secrets['stomp.psk']

  anchor {'p::server::mcollective::begin': } ->
  p::resource::package {'stomp':
    version  => $stomp_version,
    provider => gem,
  } ->
  class { '::mcollective':
    install_stomp_server => false,
    install_client       => true,
    stomp_host           => $stomp_host,
    stomp_password       => $stomp_password,
    psk                  => $stomp_psk,
    package_dependencies => '',
    dependencies_class   => '',
    install_plugins      => false,
    require              => Class['p::server::activemq'],
  } ->
  anchor {'p::server::mcollective::end': }

  create_resources($plugin_resource, $plugins, $plugins_defaults)

}