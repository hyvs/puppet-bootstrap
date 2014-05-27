class p::server::backup (
) {

  anchor {'p::server::backup::begin': } ->
  p::resource::package {'nfs-kernel-server': } ->
  anchor {'p::server::backup::end': }
}