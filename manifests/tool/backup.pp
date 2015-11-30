class p::tool::backup (
  $root = hiera('backup_root', '/var/archives'),
  $ssh_user = hiera('backup_ssh_user', 'backupagent'),
  $ssh_key = hiera('backup_ssh_key', '/home/backupagent/.ssh/id_rsa'),
  $tarballs = hiera_hash('backup_tarballs', {}),
  $mongodumps = hiera_hash('backup_mongodumps', {}),
) {

  $tarball_resource  = 'p::resource::backup::tarball'
  $tarballs_defaults = {
    require => Package['backup-manager'],
    root => $root,
    ssh_user => $ssh_user,
    ssh_key => $ssh_key,
  }

  $mongodump_resource  = 'p::resource::backup::mongodump'
  $mongodumps_defaults = {
    require => Package['backup-manager'],
    root => $root,
  }

  # Copy backup-manager package
  file { '/tmp/backup-manager.deb':
    source => 'puppet:///modules/p/backup-manager.deb',
  }

  # Install backup-manager
  package { 'backup-manager':
    provider => dpkg,
    ensure => installed,
    source => '/tmp/backup-manager.deb',
    require => File['/tmp/backup-manager.deb'],
  }

  file { '/etc/backup-manager':
    ensure  => directory,
    require => Package['backup-manager'],
  }

  # Setup cron
  file { '/etc/cron.daily/backup-manager':
    ensure => 'file',
    mode => '0755',
    content => template('p/backup/cron.erb'),
    require => Package['backup-manager'],
  }

  # Configuration tarball backups
  create_resources($tarball_resource, $tarballs, $tarballs_defaults)

  # Mongodump shell wrapper
  file { '/etc/backup-manager/mongodump.sh':
    ensure => 'file',
    mode => '0755',
    content => template('p/backup/mongodump.sh.erb'),
    require => Package['backup-manager'],
  }
  # Configuration backup mongodumps
  create_resources($mongodump_resource, $mongodumps, $mongodumps_defaults)

}