class p::agent::puppet (
) {

  if !defined(Class['p::repo::puppetlabs']) {
    class {'p::repo::puppetlabs': }
  }

  p::resource::package { 'puppet-agent': }

}