class p::client::nfs (
) {

  anchor {'p::client::nfs::begin': } ->
  p::resource::package {'nfs-common': } ->
  anchor {'p::client::nfs::end': }

}