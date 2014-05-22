class p::system::users (
  $users    = hiera_hash('users'),
  $resource = 'p::resource::user'
) {

  anchor {'p::system::users::begin': }

  $defaults = {
    require => Anchor['p::system::users::begin'],
    before  => Anchor['p::system::users::end'],
  }

  create_resources($resource, $users, $defaults)

  anchor {'p::system::users::end':
    require => Anchor['p::system::users::begin'],
  }

}