define p::resource::rabbitmq::user (
  $admin                = false,
  $configure_permission = '.*',
  $password             = undef,
  $read_permission      = '.*',
  $user                 = $name,
  $user_permission      = undef,
  $write_permission     = '.*'
) {

  if undef != $user_permission {
    $user_permission_string = $user_permission
  } else {
    $user_permission_string = "${user}@/"
  }

  rabbitmq_user {$user:
    admin    => $admin,
    password => $password,
  } ->
  rabbitmq_user_permissions { $user_permission_string:
    configure_permission => $configure_permission,
    read_permission      => $read_permission,
    write_permission     => $write_permission,
  }

}