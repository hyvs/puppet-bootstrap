class p::system::groups (
  $groups   = hiera_hash('groups'),
  $resource = 'p::resource::group'
) {

  anchor {'p::system::groups::begin': }
  
  $defaults = {
    require => Anchor['p::system::groups::begin'],
    before  => Anchor['p::system::groups::end'],
  }
  
  create_resources($resource, $groups, $defaults)
  
  anchor {'p::system::groups::end':
    require => Anchor['p::system::groups::begin'],
  }
  
}