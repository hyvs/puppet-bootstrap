define p::resource::php::pecl_module (
  $enabled = true
) {

  if $enabled {
    if !defined(Package['make']) {
      p::resource::package {'make': }
    }
    php::pecl::module {$name:
      require => Package['make'],
    }
  } else {
      php::pecl::module {$name:
      ensure  => 'absent',
    }
  }

}