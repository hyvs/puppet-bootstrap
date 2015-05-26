class p::language::php5 (
  $directives           = hiera_hash('php_directives'),
  $modules              = hiera_hash('php_modules'),
  $pecl_modules         = hiera_hash('pecl_modules'),
  $directive_resource   = 'p::resource::php::directive',
  $module_resource      = 'p::resource::php::module',
  $pecl_module_resource = 'p::resource::php::pecl_module'
) {

  $modules_defaults = {
    require => P::Resource::Package['php5-cli'],
  }

  $pecl_modules_defaults = {
    require => P::Resource::Package['php5-cli'],
  }

  $directives_defaults = {
    require => P::Resource::Package['php5-cli'],
  }

  if !defined(Class['p::repo::dotdeb']) {
    class {'p::repo::dotdeb': }
  }

  p::resource::package { 'php5-cli': }

  create_resources($module_resource, $modules, $modules_defaults)
  create_resources($pecl_module_resource, $pecl_modules, $pecl_modules_defaults)
  create_resources($directive_resource, $directives, $directives_defaults)

}