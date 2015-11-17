# Puppet class for setting up nfs server v4 only.

class p::server::nfs4 (
  $firewall            = true,
  $port                = 2049,
  $sunrpc_port         = 111,
  $exports             = hiera_hash('nfs4_exports'),
  $export_resource     = 'p::resource::nfs4::export',
  $idmap_domain        = hiera('nfs4_idmap_domain', $::domain),
  $export_root         = hiera('nfs4_export_root', '/exports'),
  $export_root_clients = hiera('nfs4_export_root_clients', "*.${::domain}(ro,fsid=root,insecure,no_subtree_check,async,root_squash)")
) {

  $exports_defaults = {
    require => P::Resource::Directory['/etc/exports.d'],
    notify  => Service['nfs-kernel-server'],
  }

  if !defined(P::Resource::Firewall::Tcp['nfs']) {
    p::resource::firewall::tcp {'nfs':
      enabled => $firewall,
      port    => $port,
    }
  }

  if !defined(P::Resource::Firewall::Tcp['sunrpc']) {
    p::resource::firewall::tcp {'sunrpc':
      enabled => $firewall,
      port    => $sunrpc_port,
    }
  }

  p::resource::package   { 'nfs-kernel-server': }
  -> p::resource::directory { '/etc/exports.d': }
  -> p::resource::directory { "${export_root}": }
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
  -> file { "/etc/exports.d/root.exports":
    content => "${export_root} ${export_root_clients}\n",
    notify  => Service['nfs-kernel-server'],
  }
  -> service { 'nfs-kernel-server': ensure => 'running', enable => true }

  create_resources($export_resource, $exports, $exports_defaults)

}