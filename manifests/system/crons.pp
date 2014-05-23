class p::system::crons (
  $crons    = hiera_hash('crons'),
  $resource = 'p::resource::cron',
  $defaults = hierahash('cron_user')
) {

  anchor {'p::system::crons::begin': }
  
  $cron_defaults = {
    user                => $defaults['cron.user'],
    default_environment => $defaults['cron.environment'],
    require             => Anchor['p::system::crons::begin'],
    before              => Anchor['p::system::crons::end'],
  }
  
  create_resources($resource, $crons, $cron_defaults)
  
  anchor {'p::system::crons::end':
    require => Anchor['p::system::crons::begin'],
  }
  
}