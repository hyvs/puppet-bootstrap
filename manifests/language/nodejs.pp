class p::language::nodejs (
  $dirs                   = hiera_hash('dirs'),
  $forever_version        = '0.10.9',
  $local_package_resource = 'p::resource::nodejs::local_package',
  $local_packages         = hiera_hash('npm_local_packages'),
  $package_resource       = 'p::resource::nodejs::package',
  $packages               = hiera_hash('npm_packages'),
  $version                = 'v0.10.27'
) {

  $tmpdir            = $dirs['tmp']
  $node_tar          = "node-${version}.tar.gz"
  $node_unpacked     = "node-${version}"
  $test_installation = "which node && test `node -v` = ${version}"
  $test_forever      = "which forever && test `forever -v` = v${forever_version}"
  $packages_defaults = {
    require => [Exec['install_npm_forever'], Anchor['p::language::nodejs::begin']],
    before  => Anchor['p::language::nodejs::end']
  }
  $local_packages_defaults = {
    require => [Exec['install_npm_forever'], Anchor['p::language::nodejs::begin']],
    before  => Anchor['p::language::nodejs::end']
  }

  anchor {'p::language::nodejs::begin': } ->
  exec {'download_node':
    command     => "curl -o ${node_tar} http://nodejs.org/dist/${version}/${node_tar}",
    cwd         => $tmpdir,
    creates     => "${tmpdir}/${node_tar}",
    require     => Package['curl'],
    unless      => $test_installation,
  } ->
  exec {'extract_node':
    command     => "tar -oxzf ${node_tar}",
    cwd         => $tmpdir,
    creates     => "${tmpdir}/${node_unpacked}",
    unless      => $test_installation,
  } ->
  exec {'configure_node':
    command     => "/bin/sh -c './configure'",
    cwd         => "${tmpdir}/${node_unpacked}",
    require     => Package['build-essential'],
    timeout     => 0,
    unless      => $test_installation,
  } ->
  exec {'make_node':
    command     => 'make',
    cwd         => "${tmpdir}/${node_unpacked}",
    timeout     => 0,
    unless      => $test_installation,
  } ->
  exec {'install_node':
    command     => 'make install',
    cwd         => "${tmpdir}/${node_unpacked}",
    timeout     => 0,
    unless      => $test_installation,
  } ->
  exec {'install_npm_forever':
    command     => "npm install -g forever@${forever_version}",
    cwd         => "${tmpdir}/${node_unpacked}",
    timeout     => 0,
    unless      => $test_forever,
  } ->
  anchor {'p::language::nodejs::end': }

  create_resources($package_resource, $packages, $packages_defaults)
  create_resources($local_package_resource, $local_packages, $local_packages_defaults)

}