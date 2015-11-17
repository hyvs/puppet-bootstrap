define p::resource::nfs4::export (
  $dir,
  $clients
) {

  $expdir = "${p::server::nfs4::export_root}/${name}"

  p::resource::directory {
    "${expdir}":
      mode => '0777',
  }

  mount {
    "${expdir}":
      ensure  => 'mounted',
      device  => "${dir}",
      atboot  => true,
      fstype  => 'none',
      options => 'rbind,_netdev',
      require => P::Resource::Directory["${expdir}"],
  }

  file { "/etc/exports.d/${name}.exports":
    content => template('p/nfs4/export.erb'),
  }

}