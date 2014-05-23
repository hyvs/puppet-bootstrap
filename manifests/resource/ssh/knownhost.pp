define p::resource::ssh::knownhost (
  $host      = $name,
  $user      = 'root',
  $ssh_user  = undef
) {

  if undef != $ssh_user {
    $location = "${ssh_user}@${host}"
  } else {
    $location = $host
  }

  exec {"add_host_to_knownhosts ${location}":
    command => "ssh -o StrictHostKeyChecking=no ${location} echo ping 2>/dev/null || true",
    user    => $user,
  }

}