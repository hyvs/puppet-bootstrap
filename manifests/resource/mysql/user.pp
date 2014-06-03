define p::resource::mysql::user (
  $database,
  $password,
  $login      = $name,
  $host       = 'localhost',
  $privileges = ['ALL'],
  $options    = ['GRANT']
) {

  if !defined(Mysql_user["${login}@${host}"]){
    mysql_user {"${login}@${host}":
      ensure                   => present,
      password_hash            => mysql_password($password),
      max_connections_per_hour => '0',
      max_queries_per_hour     => '0',
      max_updates_per_hour     => '0',
      max_user_connections     => '0',
      require                  => Class['::mysql::server'],
    }
  }

  mysql_grant { "${login}@${host}/${database}" :
    ensure     => present,
    options    => $options,
    privileges => $privileges,
    table      => "${database}.*",
    user       => "${login}@${host}",
    require    => Class['::mysql::server'],
  }

}