define p::resource::ruby::gem (
  $gem      = $name,
  $ruby_ver = undef,
  $version  = 'latest'
) {

  if undef != $ruby_ver {
    $ruby_version_string = $ruby_ver
  } else {
    $ruby_version_string = "ruby-${ruby_version}"
  }

  rvm_gem {$name:
    name         => $gem,
    ruby_version => $ruby_version_string,
    ensure       => $version,
    require      => Rvm_system_ruby[$ruby_version_string];
  }

}