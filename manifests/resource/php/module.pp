define p::resource::php::module (
  $module  = $name,
  $prefix  = undef,
  $enabled = true
) {

  if $enabled {
    ::php::module {$module:
      module_prefix => $prefix,
    }
  } else {
    ::php::module {$module:
      absent        => true,
      module_prefix => $prefix,
    }
  }

}