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
        before  => Anchor["p::resource::git::repository::${title}"],
      }
    }
  }

  anchor {"p::resource::git::repository::${title}": }

  p::resource::directory {$dir:
    owner   => $owner,
    group   => $group,
    require => Anchor["p::resource::git::repository::${title}"],
  } ->
  exec {"git clone ${repository} ${name} ${dir}":
    cwd     => $dir,
    command => "git clone ${repository} .",
    creates => "${dir}/.git",
    require => Package['git'],
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