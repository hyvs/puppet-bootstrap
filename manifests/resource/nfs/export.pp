define p::resource::nfs::export (
  $dir,
  $acls
) {
  file {"/etc/exports.d/${name}":
    content => template('p/nfs/export.erb'),
    require => File['/etc/exports.d'],
  }
}