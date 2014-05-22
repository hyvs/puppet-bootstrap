class p::system::crons (
  $crons    = hiera_hash('crons'),
  $resource = 'p::resource::cron'
) {

  anchor {'p::system::files::begin': }
  
  $defaults = {
    require => Anchor['p::system::files::begin'],
    before  => Anchor['p::system::files::end'],
  }
  
  create_resources($resource, $files, $defaults)
  
  anchor {'p::system::files::end':
    require => Anchor['p::system::files::begin'],
  }
  
}