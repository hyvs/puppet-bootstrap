define p::resource::rabbitmq::plugin (
  $plugin_dir,
  $absent = false,
  $plugin = $name
) {

  if true == any2bool($absent) {
    $ensure = 'absent'
  } else {
    $ensure = 'present'
  }

  rabbitmq_plugin {$plugin:
    ensure => $ensure,
  }

}