class p::server::nfs (
  $exports         = hiera_hash('nfs_exports'),
  $export_resource = 'p::resource::nfs::export'
) {

  $exports_defaults = {
    require => Anchor['p::server::nfs::begin'],
    before  => Anchor['p::server::nfs::end']
  }

  anchor {'p::server::nfs::begin': } ->
  p::resource::package {'nfs-kernel-server': } ->
  anchor {'p::server::nfs::end': }

  create_resources($export_resource, $exports, $exports_defaults)
}