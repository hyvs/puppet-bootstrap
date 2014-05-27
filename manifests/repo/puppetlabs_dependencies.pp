class p::repo::puppetlabs_dependencies (
) {

  anchor {'p::repo::puppetlabs_dependencies::begin': } ->
  p::resource::apt::repo {'puppetlabs_dependencies':
    location    => 'http://apt.puppetlabs.com',
    release     => 'wheezy',
    repos       => 'dependencies',
  } ->
  anchor {'p::repo::puppetlabs_dependencies::end': }

}