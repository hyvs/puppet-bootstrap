define p::resource::autofs::root (
  $dir,
  $automount_resource = 'p::resource::autofs::automount'
) {

  file {"/etc/auto.master.d/${name}.autofs":
    content => template('p/autofs/root.erb'),
    require => Package['autofs'],
  }

  $empty_hash = {}

  $automounts = hiera_hash("autofs_automounts_${name}", $empty_hash)

  file {"/etc/auto.master.d/${name}":
    content => template('p/autofs/autmount.erb'),
    require => Package['autofs'],
  }

}