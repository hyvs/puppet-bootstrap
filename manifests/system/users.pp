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

  create_resources($group_resource, $groups)
  create_resources($user_resource, $users)
  create_resources($ssh_public_key_resource, $user_authorized_keys)
  create_resources($ssh_private_key_resource, $user_keys)
  
}