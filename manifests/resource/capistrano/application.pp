define p::resource::capistrano::application (
  $dir,
  $require_dir         = undef,
  $before_apache_vhost = undef,
  $owner               = undef,
  $group               = undef
) {

  if undef != $require_dir {
    anchor {"p::resource::capistrano::application::${title}::require_dir":
      require => File[$require_dir],
    }
  } else {
    anchor {"p::resource::capistrano::application::${title}::require_dir":
    }
  }

  if undef != $before_apache_vhost {
    anchor {"p::resource::capistrano::application::${title}::before_apache_vhost":
      require => P::Resource::Apache::Vhost[$before_apache_vhost],
    }
  } else {
    anchor {"p::resource::capistrano::application::${title}::before_apache_vhost":
    }
  }

  p::resource::directory {$dir:
    owner   => $owner,
    group   => $group,
    require => Anchor["p::resource::capistrano::application::${title}::require_dir"],
  } ->
  p::resource::directory {"${dir}/empty":
    owner => $owner,
    group => $group
  } ->
  p::resource::link {"${dir}/current":
    owner  => $owner,
    group  => $group,
    target => "${dir}/empty",
    before => Anchor["p::resource::capistrano::application::${title}::before_apache_vhost"],
  }

}