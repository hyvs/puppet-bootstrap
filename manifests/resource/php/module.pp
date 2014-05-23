define p::resource::php::module (
  $module  = $name,
  $prefix  = undef,
  $enabled = true
) {

  if any2bool($enabled) {
    ::php::module {$module:
      module_prefix => $prefix,
      require       => Class['::php'],
    }
  } else {
    ::php::module {$module:
      absent        => true,
      module_prefix => $prefix,
      require       => Class['::php'],
    }
  }

}