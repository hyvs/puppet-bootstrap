class p::system::crons (
  $crons    = hiera_hash('crons'),
  $resource = 'p::resource::cron'
) {

  anchor {'p::system::crons::begin': }
  
  $defaults = {
    require => Anchor['p::system::crons::begin'],
    before  => Anchor['p::system::crons::end'],
  }
  
  create_resources($resource, $crons, $defaults)
  
  anchor {'p::system::crons::end':
    require => Anchor['p::system::crons::begin'],
  }
  
}