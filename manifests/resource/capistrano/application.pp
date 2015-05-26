define p::resource::capistrano::application (
  $dir,
  $require_dir         = undef,
  $before_apache_vhost = undef,
  $owner               = undef,
  $group               = undef
) {

     p::resource::directory { $dir:
       owner   => $owner,
       group   => $group,
       require => $require_dir ? {undef: undef, default: File[$require_dir]},
     }
  -> p::resource::directory { "${dir}/empty":
       owner => $owner,
       group => $group
     }
  -> p::resource::link { "${dir}/current":
       owner  => $owner,
       group  => $group,
       target => "${dir}/empty",
       before => $before_apache_vhost ? {undef: undef, default: P::Resource::Apache::Vhost[$before_apache_vhost]},
     }

}