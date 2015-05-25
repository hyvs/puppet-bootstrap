define p::resource::command (
  $command = $name,
  $cwd     = undef,
  $user    = undef,
  $unless  = undef,
  $creates = undef,
  $stdout  = undef,
  $stderr  = undef,
  $sudo    = false
) {

  if undef != $stdout and undef != $stderr {
    if $stdout == $stderr {
      $redirect = " > ${stdout} 2>&1"
    } else {
      $redirect = " > ${stdout} 2> ${stderr}"
    }
  } else {
    if undef != $stdout {
      $redirect = " > ${stdout} 2> /dev/null"
    } else {
      $redirect = " > /dev/null 2> ${stderr}"
    }
  }

  if $sudo {
    $sudo_string = 'sudo '
  } else {
    $sudo_string = ''
  }

  $real_command = "${sudo_string}${command}${redirect}"

  exec { "command ${name}":
    command => $real_command,
    cwd     => $cwd,
    user    => $user,
    unless  => $unless,
    creates => $creates,
  }

}