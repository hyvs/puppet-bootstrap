class p::system::commands (
  $commands         = hiera_hash('commands'),
  $command_resource = 'p::resource::command'
) {

  create_resources($command_resource, $commands)

}