define p::resource::ssh::private_key (
  $key,
  $login,
  $home   = undef,
  $absent = false
) {

  if undef == $home {
    $real_home = "/home/${login}"
  } else {
    $real_home = $home
  }

  $ssh_dir  = "${real_home}/.ssh"

  if !any2bool($absent) {
    $ensure = 'present'
  } else {
    $ensure = 'absent'
  }

  if !defined(File[$ssh_dir]) {
    p::resource::directory {$ssh_dir:
      owner   => $login,
      group   => $login,
      mode    => 0600,
    }
  }

  file {"${ssh_dir}/${name}":
    ensure  => $ensure,
    content => $key,
    owner   => $login,
    group   => $login,
    mode    => 0600,
    require => [User[$login], File[$ssh_dir]],
  }

}