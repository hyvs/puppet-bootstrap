define p::resource::php::pear_module (
  $repository,
  $module      = $name,
  $use_package = "false",
  $enabled     = true
) {

  if any2bool($enabled) {
    php::pear::module {$module:
      repository  => $repository,
      use_package => $use_package,
    }
  } else {
    php::pear::module {$module:
      ensure      => 'absent',
      repository  => $repository,
      use_package => $use_package,
    }
  }

}