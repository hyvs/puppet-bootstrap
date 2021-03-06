class p::tool::phantomjs (
  $dirs    = hiera_hash('dirs'),
  $version = '1.9.7'
) {

  $tmp_dir      = $dirs['tmp']
  $tar          = "phantomjs-${version}-linux-x86_64.tar.bz2"
  $unpacked     = "phantomjs-${version}-linux-x86_64"
  $test_install = "which phantomjs && test `phantomjs -v` = ${version}"

  if !defined(Package['wget']) {
    p::resource::package {'wget':
      require => Anchor['p::tool::phantomjs::begin'],
      before  => Anchor['p::tool::phantomjs::end'],
    }
  }

  anchor {'p::tool::phantomjs::begin': } ->
  exec {'download_phantomjs':
    command     => "wget -O ${tar} https://bitbucket.org/ariya/phantomjs/downloads/${tar}",
    cwd         => $tmp_dir,
    creates     => "${tmp_dir}/${tar}",
    require     => Package['wget'],
    unless      => $test_install,
  } ->
  exec {'extract_phantomjs':
    command     => "tar -oxjf ${tar}",
    cwd         => $tmp_dir,
    creates     => "${tmp_dir}/${unpacked}",
    unless      => $test_install,
  } ->
  exec {'install_phantomjs':
    command     => 'sudo cp bin/phantomjs /usr/bin/phantomjs',
    cwd         => "${tmp_dir}/${unpacked}",
    timeout     => 0,
    unless      => $test_install,
  } ->
  anchor {'p::tool::phantomjs::end': }

}