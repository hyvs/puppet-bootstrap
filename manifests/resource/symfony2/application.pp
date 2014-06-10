define p::resource::symfony2::application (
  $dir,
  $default_docroot,
  $deploy               = false,
  $directories          = ['app/cache', 'app/logs'],
  $users                = ['`whoami`', 'www-data', 'root'],
  $owner                = 'www-data',
  $group                = 'www-data',
  $install_log_file     = 'app/logs/puppet.log',
  $command_resource     = 'p::resource::symfony2::command',
  $install_assets_mode  = 'symlink',
  $commands             = undef,
  $env                  = 'dev',
  $require_git_repos    = undef,
  $require_mysql_db     = undef,
  $migrate_db           = false,
  $zenstruck_migrate_db = false,
  $clear_cache          = true,
  $dump_assetics        = false,
  $install_assets       = false
) {


  if undef != $require_git_repos {
    anchor {"p::resource::symfony2::application::git_repos::${title}":
      require => P::Resource::Git::Repository[$require_git_repos],
    }
  } else {
    anchor {"p::resource::symfony2::application::git_repos::${title}": }
  }

  if undef != $require_mysql_db {
    anchor {"p::resource::symfony2::application::mysql_db::${title}":
      require => P::Resource::Mysql::Database[$require_mysql_db],
    }
  } else {
    anchor {"p::resource::symfony2::application::mysql_db::${title}": }
  }

  validate_array($users)
  validate_array($directories)

  if any2bool($deploy) {
    $directories.each |$directory| {
      p::resource::directory {"${dir}/${directory}":
        owner   => $owner,
        group   => $group,
        require => [File[$dir], Anchor["p::resource::symfony2::application::git_repos::${title}"], Anchor["p::resource::symfony2::application::mysql_db::${title}"]]
      }
    }

    $users.each |$user| {
      $directories.each |$directory| {
        exec {"symfony2 directory permissions on ${dir}/${directory} for user ${user}" :
          cwd     => $dir,
          command => "sudo rm -rf ${directory}/* && sudo setfacl -dR -m u:${user}:rwx ${directory} && sudo setfacl -R -m u:${user}:rwX ${directory}",
          require => [P::Resource::Directory["${dir}/${directory}"], Package['acl']],
          before  => P::Resource::Composer::Project[$dir],
        }
      }
    }

    p::resource::composer::project {$dir: } ->
    anchor {"p::resource::symfony2::application::init_commands::${title}": } ->
    anchor {"p::resource::symfony2::application::pre_commands::${title}": } ->
    anchor {"p::resource::symfony2::application::commands::${title}": } ->
    anchor {"p::resource::symfony2::application::post_commands::${title}": }

    if any2bool($clear_cache) {
      p::resource::symfony2::command::cache_clear {$dir:
        env     => $env,
        stdout  => $install_log_file,
        stderr  => $install_log_file,
        require => Anchor["p::resource::symfony2::application::init_commands::${title}"],
        before  => Anchor["p::resource::symfony2::application::pre_commands::${title}"],
      }
    }

    if is_hash($commands) {
      $commands.each |$command_name, $command| {
        create_resources(
          $command_resource,
          {
            "${dir} ${command_name}" => $command
          },
          {
            dir        => $dir,
            env        => $env,
            require    => Anchor["p::resource::symfony2::application::commands::${title}"],
            stdout     => $install_log_file,
            stderr     => $install_log_file,
            log_append => true,
            before     => Anchor["p::resource::symfony2::application::post_commands::${title}"]
          }
        )
      }
    }

    if any2bool($dump_assetics) {
      p::resource::symfony2::command::assetic_dump {$dir:
        env    => $env,
        force  => true,
        stdout => $install_log_file,
        stderr => $install_log_file,
        require => Anchor["p::resource::symfony2::application::pre_commands::${title}"],
        before  => Anchor["p::resource::symfony2::application::commands::${title}"],
      }
    }

    if any2bool($migrate_db) {
      p::resource::symfony2::command::doctrine_migrations_migrate {$dir:
        env    => $env,
        stdout => $install_log_file,
        stderr => $install_log_file,
        require => Anchor["p::resource::symfony2::application::pre_commands::${title}"],
        before  => Anchor["p::resource::symfony2::application::commands::${title}"],
      }
    }

    if any2bool($zenstruck_migrate_db) {
      p::resource::symfony2::command::zenstruck_migrations_migrate {$dir:
        env     => $env,
        stdout  => $install_log_file,
        stderr  => $install_log_file,
        require => Anchor["p::resource::symfony2::application::pre_commands::${title}"],
        before  => Anchor["p::resource::symfony2::application::commands::${title}"],
      }
    }

    if any2bool($install_assets) {
      p::resource::symfony2::command::assets_install {$dir:
        mode    => $install_assets_mode,
        stdout  => $install_log_file,
        stderr  => $install_log_file,
        require => Anchor["p::resource::symfony2::application::post_commands::${title}"],
      }
    }
  } else {
    file {"${dir}/web":
      ensure  => 'link',
      replace => 'no',
      target  => $default_docroot,
      owner   => $owner,
      group   => $group,
    }
  }

}