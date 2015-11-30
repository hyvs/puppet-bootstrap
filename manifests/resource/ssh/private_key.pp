define p::resource::ssh::private_key (
  $key,
  $login,
  $group  = 'users',
  $home   = undef,
  $absent = false
) {

  if undef == $home {
    $real_home = "/home/${login}"
  } else {
    $real_home = $home
  }

  $ssh_dir  = "${real_home}/.ssh"

  if !$absent {
    $ensure = 'present'
  } else {
    $ensure = 'absent'
  }

  if !defined(P::Resource::Directory[$ssh_dir]) {
    p::resource::directory {$ssh_dir:
      owner   => $login,
      group   => $group,
      mode    => '0600',
    }
  }

  file {"${ssh_dir}/${name}":
    ensure  => $ensure,
    content => $key,
    owner   => $login,
    group   => $group,
    mode    => '0600',
    require => [User[$login], P::Resource::Directory[$ssh_dir]],
  }

}