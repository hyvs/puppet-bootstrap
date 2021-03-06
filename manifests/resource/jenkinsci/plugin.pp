define p::resource::jenkinsci::plugin (
  $ensure     = 'present',
  $plugin_dir = '/var/lib/jenkins/plugins'
) {

  if 'absent' == $ensure {
    file {"${plugin_dir}/${name}.jpi" :
      ensure  => absent,
      notify  => Service['jenkins'],
    } ->
    file {"${plugin_dir}/${name}.hpi" :
      ensure  => absent,
      notify  => Service['jenkins'],
    } ->
    file {"${plugin_dir}/${name}" :
      ensure  => absent,
      force   => true,
      notify  => Service['jenkins'],
    }
  } else {
    ::jenkins::plugin {$name: }
  }

}