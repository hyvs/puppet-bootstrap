# Puppet class for setting up nfs client v4 only.

class p::client::nfs4 (
  $mount_root     = hiera('nfs4_mount_root', '/mnt'),
  $idmap_domain   = hiera('nfs4_idmap_domain', $::domain),
  $mounts         = hiera_hash('nfs4_mounts'),
  $mount_resource = 'p::resource::nfs4::mount'
) {

  $mounts_defaults = {
    notify  => Service['nfs-common'],
  }

  p::resource::package {'nfs-common': }
  -> augeas {
    '/etc/default/nfs-common':
      context => '/files/etc/default/nfs-common',
      changes => [ 'set NEED_IDMAPD yes', ];
    '/etc/idmapd.conf':
      context => '/files/etc/idmapd.conf/General',
      lens    => 'Puppet.lns',
      incl    => '/etc/idmapd.conf',
      changes => ["set Domain ${idmap_domain}"],
  }
  -> service { 'nfs-common': ensure => 'running', enable => true }

  create_resources($mount_resource, $mounts, $mounts_defaults)

}