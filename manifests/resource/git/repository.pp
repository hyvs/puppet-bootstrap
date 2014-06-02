define p::resource::git::repository (
  $dir,
  $repository,
  $branch      = 'master',
  $group       = 'root',
  $owner       = 'root',
  $require_dir = undef
) {

  if undef != $require_dir {
    if !defined(P::Resource::Directory[$require_dir]) {
      p::resource::directory {$require_dir:
        owner   => $owner,
        group   => $group,
      }
    }
  }

  p::resource::directory {$dir:
    owner   => $owner,
    group   => $group,
    require => defined(P::Resource::Directory[$require_dir]) ? {false => undef, true => P::Resource::Directory[$require_dir]}
  } ->
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
  }

}