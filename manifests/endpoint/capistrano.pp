class p::endpoint::capistrano (
  $applications         = hiera_hash('capistrano_applications'),
  $home                 = hiera('capistrano_home'),
  $application_resource = 'p::resource::capistrano::application',
  $home_owner           = undef,
  $home_group           = undef
) {

  $applications_defaults = {
    require => P::Resource::Directory[$home],
    before  => Anchor['p::endpoint::capistrano::end']
  }

     anchor {'p::endpoint::capistrano::begin': }
  -> p::resource::directory {$home: owner => $home_owner, group => $home_group }
  -> anchor {'p::endpoint::capistrano::end':   }

  create_resources($application_resource, $applications, $applications_defaults)

}