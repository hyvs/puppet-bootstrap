class p::provider::gandi (
  $defaults                = hiera_hash('gandi_defaults'),
  $system_defaults         = hiera_hash('gandi_system_defaults'),
  $default_resource        = 'p::resource::config',
  $system_default_resource = 'p::resource::config',
  $default_file            = '/etc/default/gandi',
  $system_default_file     = '/etc/sysconfig/gandi'
) {

  $defaults_defaults = {
    file    => $default_file
  }

  $system_defaults_defaults = {
    file    => $system_default_file
  }

  create_resources($default_resource, $defaults, $defaults_defaults)
  create_resources($system_default_resource, $system_defaults, $system_defaults_defaults)

}