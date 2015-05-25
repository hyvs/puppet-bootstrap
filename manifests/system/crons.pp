class p::system::crons (
  $crons       = hiera_hash('crons'),
  $environment = hiera_hash('cron_environment'),
  $resource    = 'p::resource::cron',
  $user        = 'root'
) {

  $cron_defaults = {
    user                => $user,
    default_environment => $environment,
    require             => Anchor['p::system::crons::begin'],
    before              => Anchor['p::system::crons::end'],
  }

     anchor { 'p::system::crons::begin': }
  -> anchor { 'p::system::crons::end':   }

  create_resources($resource, $crons, $cron_defaults)

}