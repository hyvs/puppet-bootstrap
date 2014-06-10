class p::client::mcollective (
  $plugin_resource = 'p::resource::mcollective::plugin',
  $stomp_version   = '1.2.2',
  $stomp_host      = 'localhost',
  $stomp_user      = 'mcollective',
  $stomp_admin     = 'admin',
  $plugins         = hiera_hash('mcollective_plugins'),
  $secrets         = hiera_hash('secrets')
) {

  $plugins_defaults = {
  }

  $stomp_password       = $secrets['stomp.password']
  $stomp_admin_password = $secrets['stomp.admin.password']
  $stomp_psk            = $secrets['stomp.psk']

  anchor {'p::client::mcollective::begin': } ->
  p::resource::package {'stomp':
    version  => $stomp_version,
    provider => gem,
  } ->
  class { '::mcollective':
    install_stomp_server => false,
    install_client       => true,
    stomp_user           => $stomp_user,
    stomp_admin          => $stomp_admin,
    stomp_admin_password => $stomp_admin_password,
    stomp_host           => $stomp_host,
    stomp_password       => $stomp_password,
    psk                  => $stomp_psk,
    package_dependencies => '',
    dependencies_class   => '',
    install_plugins      => false,
  } ->
  anchor {'p::client::mcollective::end': }

  create_resources($plugin_resource, $plugins, $plugins_defaults)

}