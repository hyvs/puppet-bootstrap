define p::resource::nfs::export (
  $dir,
  $acls
) {
  file {"/etc/exports.d/${name}.exports":
    content => template('p/nfs/export.erb'),
    require => File['/etc/exports.d'],
  }
}