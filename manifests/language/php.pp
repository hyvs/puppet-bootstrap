class p::language::php5 (
  $directives           = hiera_hash('php_directives'),
  $modules              = hiera_hash('php_modules'),
  $pecl_modules         = hiera_hash('pecl_modules'),
  $directive_resource   = 'p::resource::php::directive',
  $module_resource      = 'p::resource::php::module',
  $pecl_module_resource = 'p::resource::php::pecl_module'
) {

  $modules_defaults = {
    require => Class['::php'],
    before  => Anchor['p::language::php::end']
  }

  $pecl_modules_defaults = {
    require => Class['::php'],
    before  => Anchor['p::language::php::end']
  }

  $directives_defaults = {
    require => Class['::php'],
    before  => Anchor['p::language::php::end']
  }

  if !defined(Class['p::repo::dotdeb']) {
    class {'p::repo::dotdeb': }
  }

     anchor               {'p::language::php::begin': }
  -> p::resource::package { 'php5-cli': }
  -> anchor               {'p::language::php::end': }

  create_resources($module_resource, $modules, $modules_defaults)
  create_resources($pecl_module_resource, $pecl_modules, $pecl_modules_defaults)
  create_resources($directive_resource, $directives, $directives_defaults)

}