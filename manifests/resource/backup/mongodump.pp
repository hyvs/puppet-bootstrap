define p::resource::backup::mongodump (
  $root,
  $host,
) {

  file {"/etc/backup-manager/mongodump_${name}.conf":
    content => template('p/backup/mongodump.conf.erb'),
  }
}