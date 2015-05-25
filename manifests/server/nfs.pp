class p::server::nfs (
  $exports         = hiera_hash('nfs_exports'),
  $export_resource = 'p::resource::nfs::export'
) {

  $exports_defaults = {
    require => P::Resource::Directory['/etc/exports.d'],
    before  => Anchor['p::server::nfs::end'],
    notify  => Service['nfs-kernel-server'],
  }

    anchor                  { 'p::server::nfs::begin': }
  -> p::resource::package   { 'nfs-kernel-server':     }
  -> p::resource::directory { '/etc/exports.d':        }
  -> service                { 'nfs-kernel-server': ensure => 'running', enable => true }
  -> anchor                 { 'p::server::nfs::end':   }

  create_resources($export_resource, $exports, $exports_defaults)

}