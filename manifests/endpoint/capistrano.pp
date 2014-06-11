class p::endpoint::capistrano (
  $applications         = hiera('capistrano_applications'),
  $application_resource = 'p::resource::capistrano::application',
  $dirs                 = hiera('dirs'),
  $home_owner           = undef,
  $home_group           = undef
) {

  $home = $dirs['capistrano.home']

  $applications_defaults = {
    require => [P::Resource::Directory[$home], File[$home]],
    before  => Anchor['p::endpoint::capistrano::end']
  }

  anchor {'p::endpoint::capistrano::begin': } ->
  p::resource::directory {$home:
    owner => $home_owner,
    group => $home_group
  } ->
  anchor {'p::endpoint::capistrano::end': }

  create_resources($application_resource, $applications, $applications_defaults)
}