class p::system::hosts (
  $hosts    = hiera_hash('hosts'),
  $resource = 'p::resource::host'
) {

  $defaults = {
    require => Anchor['p::system::hosts::begin'],
    before  => Anchor['p::system::hosts::end'],
  }

     anchor { 'p::system::hosts::begin': }
  -> anchor { 'p::system::hosts::end':   }

  create_resources($resource, $hosts, $defaults)

}