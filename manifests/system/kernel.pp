class p::system::kernel (
  $directives = hiera_hash('sysctl'),
  $resource   = 'p::resource::config',
  $file       = '/etc/sysctl.d/local.conf'
) {

  if !defined(Exec['reload network']) {
    exec { 'reload network': command => "sudo service networking restart" }
  }

  $defaults = {
    before  => Exec['reload network'],
  }

  create_resources($resource, $directives, $defaults)

}