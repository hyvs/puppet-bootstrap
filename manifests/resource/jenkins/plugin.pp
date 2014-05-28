define p::resource::jenkins::plugin (
  $ensure     = 'present',
  $plugin_dir = '/var/lib/jenkins/plugins'
) {

  if 'absent' == $ensure {
    file {"${plugin_dir}/${name}.jpi" :
      ensure  => absent,
      notify  => Service['jenkins'],
    } ->
    file {"${plugin_dir}/${name}.hdi" :
      ensure  => absent,
      notify  => Service['jenkins'],
    } ->
    file {"${plugin_dir}/${name}" :
      ensure  => absent,
      force   => true,
      notify  => Service['jenkins'],
    }
  } else {
    jenkins::plugin {$name: }
  }

}