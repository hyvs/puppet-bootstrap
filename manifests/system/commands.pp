class p::system::commands (
  $command_resource = 'p::resource::command',
  $commands         = hiera_hash('commands')
) {

  $commands_defaults = {
    require => Anchor['p::system::commands::begin'],
    before => Anchor['p::system::commands::end']
  }

  anchor {'p::system::commands::begin': } ->
  anchor {'p::system::commands::end': }

  create_resources($command_resource, $commands, $commands_defaults)

}