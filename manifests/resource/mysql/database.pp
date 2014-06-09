define p::resource::mysql::database (
  $default_user_password,
  $charset       = 'utf8',
  $collate       = 'utf8_swedish_ci',
  $users         = undef,
  $user_resource = 'p::resource::mysql::user'
) {

  $users_defaults = {
    password => $default_user_password,
    database => $name
  }

  mysql_database {$name:
    ensure  => present,
    charset => $charset,
    collate => $collate,
    require => Class['::mysql::server'],
  }

  if undef != $users {
    create_resources($user_resource, $users, $users_defaults)
  }

}