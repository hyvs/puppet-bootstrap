define p::resource::nodejs::package (
  $version        = undef,
  $after_package  = undef,
  $before_package = undef,
  $manual_install = true
) {

  if undef != $version {
    $ensure = $version
  } else {
    $ensure = 'latest'
  }

  if undef != $before_package {
    $before = P::Resource::Nodejs::Package[$before_package]
  } else {
    $before = undef
  }
  if undef != $after_package {
    $require = [P::Resource::Nodejs::Package[$after_package], Class['p::language::nodejs']]
  } else {
    $require = Class['p::language::nodejs']
  }

  if !$manual_install {
    p::resource::package {$name:
      ensure   => $version,
      provider => 'npm',
      before   => $before,
      require  => $require,
    }
  } else {
    if undef != $version {
      $full_name = "${name}@${version}"
    } else {
      $full_name = $name
    }
    exec {"npm install global ${name}@${version}":
      cwd      => '/root',
      command  => "sudo HOME=/root npm install --global ${full_name}",
      unless   => "test `npm list | grep ${full_name} | wc -l` -eq 1",
      before   => $before,
      require  => $require,
    }
  }

}