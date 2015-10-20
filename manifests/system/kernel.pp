class p::system::kernel (
  $directives = hiera_hash('sysctl'),
  $resource   = 'p::resource::config',
  $file       = '/etc/sysctl.d/local.conf'
) {

  $defaults = {
    file    => $file,
    before  => Exec['reload network'],
  }

  create_resources($resource, $directives, $defaults)

}