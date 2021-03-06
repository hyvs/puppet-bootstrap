class p::tool::composer (
  $dirs             = hiera_hash('dirs'),
  $full_bin         = '/usr/bin/composer',
  $bin              = 'composer',
  $filename         = 'composer.phar',
  $download_command = 'curl -S http://getcomposer.org/installer | php',
  $project_resource = 'p::resource::composer::project',
  $projects         = hiera_hash('composer_projects')
) {

  anchor {'p::tool::composer::begin': }

  $tmp_dir      = $dirs['tmp']
  $test_install = "which ${bin}"

  $projects_defaults = {
    require => Exec["install_${filename}"],
    before  => Anchor['p::tool::composer::end'],
  }

  if !defined(Package['curl']) and !defined(P::Resource::Package['curl']) {
    p::resource::package {'curl':
      require => Anchor['p::tool::composer::begin'],
      before  => Anchor['p::tool::composer::end'],
    }
  }

  exec {'download composer.phar':
    command     => "${download_command}",
    cwd         => $tmp_dir,
    creates     => "${tmp_dir}/${filename}",
    require     => [Package['curl'], Package['php5-cli'], Anchor['p::tool::composer::begin']],
    unless      => $test_install,
  } ->
  exec {"install_${filename}":
    command     => "sudo cp ${filename} ${full_bin}",
    cwd         => $tmp_dir,
    unless      => $test_install,
    before      => Anchor['p::tool::composer::end'],
  }

  anchor {'p::tool::composer::end': }

  create_resources($project_resource, $projects, $projects_defaults)

}