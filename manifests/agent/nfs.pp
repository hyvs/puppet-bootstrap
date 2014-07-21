class p::agent::nfs (
) {

  anchor {'p::agent::nfs::begin': } ->
  p::resource::package {'nfs-common': } ->
  anchor {'p::agent::nfs::end':   }

}