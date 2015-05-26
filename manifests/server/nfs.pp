class p::server::nfs (
  $exports         = hiera_hash('nfs_exports'),
  $export_resource = 'p::resource::nfs::export'
) {

  $exports_defaults = {
    require => P::Resource::Directory['/etc/exports.d'],
    notify  => Service['nfs-kernel-server'],
  }

     p::resource::package   { 'nfs-kernel-server':     }
  -> p::resource::directory { '/etc/exports.d':        }
  -> service                { 'nfs-kernel-server': ensure => 'running', enable => true }

  create_resources($export_resource, $exports, $exports_defaults)

}