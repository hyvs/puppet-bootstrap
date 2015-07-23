define p::resource::php::pecl_module (
  $enabled = true
  $version = undef,
  $required_packages = []
) {

  if !defined(Package['php5-cli']) and !defined(P::Resource::Package['php5-cli']) {
    p::resource::package { 'php5-cli': }
  }

  if !defined(Package['php5-dev']) and !defined(P::Resource::Package['php5-dev']) {
    p::resource::package { 'php5-dev': }
  }

  $required_packages.each |$required_package| {
    if !defined(Package[$required_package]) and !defined(P::Resource::Package[$required_package]) {
      p::resource::package { $required_package:
        before => Package['php5-dev'],
      }
    }
  }

  if $enabled {
    exec { "install pecl module ${name}":
      command => "sudo pecl install ${name}",
      require => [Package['php5-dev'], Package['php5-cli']],
    } ->
      file { "/etc/php5/mods-available/${name}.ini":
      content => "extension=${name}.so",
    } ->
      exec { "enable php module ${name}":
      command => "sudo php5enmod ${name}",
    }
  } else {
    exec { "disable php module ${name}":
      command => "sudo php5dismod ${name} || echo",
      require => [Package['php5-dev'], Package['php5-cli']],
    }
  }

}