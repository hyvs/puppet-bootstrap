class p::framework::symfony2 (
  $application_resource = 'p::resource::symfony2::application',
  $applications         = hiera_hash('symfony2_applications')
) {

  anchor {'p::framework::symfony2::begin': }

  $applications_defaults = {
    require => Anchor['p::framework::symfony2::begin'],
    before  => Anchor['p::framework::symfony2::end'],
  }

  if !defined(Package['php5-cli']) and !defined(P::Resource::Package['php5-cli']) {
    p::resource::package {'php5-cli':
      require => Anchor['p::framework::symfony2::begin'],
      before  => Anchor['p::framework::symfony2::end'],
    }
  }

  anchor {'p::framework::symfony2::end': }

  create_resources($application_resource, $applications, $applications_defaults)

}