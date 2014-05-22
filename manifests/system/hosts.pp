class p::system::hosts (
  $hosts    = hiera_hash('hosts'),
  $resource = 'p::resource::host'
) {

  anchor {'p::system::hosts::begin': }
  
  $defaults = {
    require => Anchor['p::system::hosts::begin'],
    before  => Anchor['p::system::hosts::end'],
  }
  
  create_resources($resource, $hosts, $defaults)
  
  anchor {'p::system::hosts::end':
    require => Anchor['p::system::hosts::begin'],
  }
  
}