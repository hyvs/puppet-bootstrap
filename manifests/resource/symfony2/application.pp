define p::resource::symfony2::application (
  $dir,
  $directories          = ['app/cache', 'app/logs'],
  $users                = ['`whoami`', 'www-data', 'root'],
  $owner                = 'www-data',
  $group                = 'www-data',
  $install_log_file     = 'app/logs/puppet.log',
  $command_resource     = 'p::resource::symfony2::command',
  $install_assets_mode  = 'symlink',
  $commands             = undef,
  $env                  = 'dev',
  $require_git_repos    = undef
) {


  if undef != $require_git_repos {
    anchor {"p::resource::symfony2::application::${title}":
      require => P::Resource::Git::Repository[$require_git_repos],
    }
  } else {
    anchor {"p::resource::symfony2::application::${title}": }
  }

  validate_array($users)
  validate_array($directories)

  $directories.each |$directory| {
    p::resource::directory {"${dir}/${directory}":
      owner   => $owner,
      group   => $group,
      require => [File[$dir], Anchor["p::resource::symfony2::application::${title}"]]
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
  p::resource::symfony2::command::cache_clear {$dir:
    env => $env,
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
          require    => P::Resource::Symfony2::Command::Cache_clear[$dir],
          stdout     => $install_log_file,
          stderr     => $install_log_file,
          log_append => true,
          before     => P::Resource::Symfony2::Command::Assets_install[$dir]
        }
      )
    }
  }

  p::resource::symfony2::command::assets_install {$dir:
    mode    => $install_assets_mode,
  }

}