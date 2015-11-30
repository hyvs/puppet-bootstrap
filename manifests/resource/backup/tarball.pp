define p::resource::backup::tarball (
  $root,
  $ssh_user,
  $ssh_key,
  $host,
  $directories,
) {

  file {"/etc/backup-manager/tarball_${name}.conf":
    content => template('p/backup/tarball.conf.erb'),
  }
}