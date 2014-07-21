class p::server::nfs (
) {

  anchor {'p::server::nfs::begin': } ->
  p::resource::package {'nfs-kernel-server': } ->
  anchor {'p::server::nfs::end': }

}