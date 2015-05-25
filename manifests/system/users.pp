class p::system::users (
  $groups                   = hiera_hash('groups'),
  $user_authorized_keys     = hiera_hash('user_authorized_keys'),
  $user_keys                = hiera_hash('user_keys'),
  $users                    = hiera_hash('users'),
  $group_resource           = 'p::resource::group',
  $ssh_private_key_resource = 'p::resource::ssh::private_key',
  $ssh_public_key_resource  = 'p::resource::ssh::public_key',
  $user_resource            = 'p::resource::user'
) {

  $groups_defaults = {
    require => Anchor['p::system::users::begin'],
    before  => Anchor['p::system::users::end']
  }
  
  $users_defaults = {
    require => Anchor['p::system::users::begin'],
    before  => Anchor['p::system::users::end']
  }
  
  $ssh_public_keys_defaults = {
    require => Anchor['p::system::users::begin'],
    before  => Anchor['p::system::users::end']
  }
  
  $ssh_private_keys_defaults = {
    require => Anchor['p::system::users::begin'],
    before  => Anchor['p::system::users::end']
  }

     anchor { 'p::system::users::begin': }
  -> anchor { 'p::system::users::end':   }

  create_resources($group_resource, $groups, $groups_defaults)
  create_resources($user_resource, $users, $users_defaults)
  create_resources($ssh_public_key_resource, $user_authorized_keys, $ssh_public_keys_defaults)
  create_resources($ssh_private_key_resource, $user_keys, $ssh_private_keys_defaults)
  
}