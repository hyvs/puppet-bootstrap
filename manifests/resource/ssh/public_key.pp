define p::resource::ssh::public_key (
  $key,
  $login,
  $home   = undef,
  $type   = 'ssh-rsa',
  $absent = false
) {

  if undef == $home {
    $real_home = "/home/${login}"
  } else {
    $real_home = $home
  }

  $ssh_dir  = "${real_home}/.ssh"
  $key_name = "${login}_${name}"

  if $absent {
    $ensure = 'absent'
  } else {
    $ensure = 'present'
  }

  if !defined(File[$ssh_dir]) {
    p::resource::directory {$ssh_dir:
      owner   => $login,
      group   => $login,
      mode    => '0600',
    }
  }

  ssh_authorized_key {$key_name:
    type    => $type,
    key     => $key,
    ensure  => $ensure,
    user    => $login,
    require => [User[$login], File[$ssh_dir]],
  }

}