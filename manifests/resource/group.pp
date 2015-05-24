define p::resource::group (
  $gid        = undef,
  $group      = $name,
  $sudonopass = false,
  $enabled    = true
) {

  $conf_file      = "/etc/sudoers.d/hiera-${group}-sudonopass"
  $conf_statement = "%${group} ALL = NOPASSWD: ALL"

  if $enabled {
    group {$name:
      ensure  => present,
      gid     => $gid,
      name    => $group,
    }

    if $sudonopass {
      file {$conf_file:
        ensure  => file,
        content => $conf_statement,
        require => Group[$group],
      }
    }
  } else {
    group {$name:
      ensure  => absent,
    }
    if $sudonopass {
      file {$conf_file:
        ensure  => absent,
      }
    }
  }

}