class p::tool::composer (
  $full_bin         = '/usr/bin/composer',
  $tmp_dir          = '/tmp',
  $bin              = 'composer',
  $test_install     = 'which composer',
  $filename         = 'composer.phar',
  $download_command = 'curl -sS https://getcomposer.org/installer | php'
) {

  if !defined(Package['curl']) and !defined(P::Resource::Package['curl']) {
    p::resource::package {'curl':
      require => Anchor['p::tool::composer::begin'],
      before  => Anchor['p::tool::composer::end'],
    }
  }

     anchor { 'p::tool::composer::begin': }
  -> exec   { 'download composer.phar':
       command => "${download_command}",
       cwd     => $tmp_dir,
       creates => "${tmp_dir}/${filename}",
       require => [Package['curl'], Package['php5-cli']],
       unless  => $test_install,
     }
  -> exec   { "install_${filename}":
       command => "sudo cp ${filename} ${full_bin}",
       cwd     => $tmp_dir,
       unless  => $test_install,
     }
  -> anchor { 'p::tool::composer::end': }

}