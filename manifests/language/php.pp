class p::language::php (
  $directive_resource   = 'p::resource::php::directive',
  $directives           = hiera_hash('php_directives'),
  $module_resource      = 'p::resource::php::module',
  $modules              = hiera_hash('php_modules'),
  $pear_module_resource = 'p::resource::php::pear_module',
  $pear_modules         = hiera_hash('pear_modules'),
  $pecl_module_resource = 'p::resource::php::pecl_module',
  $pecl_modules         = hiera_hash('pecl_modules')
) {

  $modules_defaults = {
    require => Class['::php'],
    before  => Anchor['p::language::php::end']
  }

  $pecl_modules_defaults = {
    require => Class['::php'],
    before  => Anchor['p::language::php::end']
  }

  $pear_modules_defaults = {
    require => Class['::php'],
    before  => Anchor['p::language::php::end']
  }

  $directives_defaults = {
    require => Class['::php'],
    before  => Anchor['p::language::php::end']
  }

  anchor {'p::language::php::begin': } ->
  class {'::php': } ->
  p::resource::package { 'php5-cli': } ->
  anchor {'p::language::php::end': }

  create_resources($module_resource, $modules, $modules_defaults)
  create_resources($pecl_module_resource, $pecl_modules, $pecl_modules_defaults)
  create_resources($pear_module_resource, $pear_modules, $pear_modules_defaults)
  create_resources($directive_resource, $directives, $directives_defaults)

}