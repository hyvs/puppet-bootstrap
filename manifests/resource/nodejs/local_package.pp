define p::resource::nodejs::local_package (
  $dir         = '',
  $ensure      = 'present',
  $install_opt = undef,
  $remove_opt  = undef,
  $source      = undef,
  $version     = 'latest'
) {

  nodejs::npm {$name:
    ensure      => present,
    install_dir => $dir,
    install_opt => $install_opt,
    pkg_name    => $name,
    remove_opt  => $remove_opt,
    source      => $source,
    version     => $version,
  }

}