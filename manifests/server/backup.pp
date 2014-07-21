class p::server::backup (
) {

  anchor {'p::server::backup::begin': } ->
  anchor {'p::server::backup::end': }

  if !defined(Class['p::server::nfs']) {
    class {'p::server::nfs':
      require => Anchor['p::server::backup::begin'],
      before  => Anchor['p::server::backup::end'],
    }
  }

}