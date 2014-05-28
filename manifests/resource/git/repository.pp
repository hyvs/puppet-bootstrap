define p::resource::git::repository (
  $dir,
  $repository,
  $branch = 'master',
  $group  = 'root',
  $owner  = 'root'
) {

  exec {"git clone ${repository} ${name} ${dir}":
    cwd     => $dir,
    command => "git clone ${repository} .",
    creates => "${repo_dir}/.git",
    require => File[$apps_dir],
  } ->
  exec {"git pull ${repository} ${name} ${dir}":
    cwd     => $dir,
    command => "git pull",
  } ->
  exec {"git checkout ${branch} ${repository} ${name} ${dir}":
    cwd     => $dir,
    command => "git checkout ${branch}",
  } ->
  ftven_build::resource::directory {$dir:
    owner   => $owner,
    group   => $group,
  }

}