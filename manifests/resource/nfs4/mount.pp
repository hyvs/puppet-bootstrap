define p::resource::nfs4::mount (
  $ensure = 'mounted',
  $server,
  $share = $title,
  $mount = "${p::client::nfs4::mount_root}/${title}",
  $options = 'nouser,noexec,nodev,suid,auto,rw,x-systemd.automount,x-systemd.device-timeout=10,timeo=14,x-systemd.idle-timeout=1min',
  $group = 'root',
  $mode  = undef,
  $owner = 'root'
) {

  p::resource::directory {
    "${mount}":
      group => $group,
      owner => $owner,
      mode  => $mode,
  }

  mount {
    "shared $share on ${mount}":
      ensure   => $ensure,
      device   => "${server}:/${share}",
      fstype   => 'nfs4',
      name     => "${mount}",
      options  => $options,
      require  => P::Resource::Directory["${mount}"],
  }

}