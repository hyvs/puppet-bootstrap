class p::agent::puppet (
) {

  if !defined(Class['p::repo::puppetlabs']) {
    class {'p::repo::puppetlabs': }
  }

     anchor               { 'p::agent::puppet::begin': }
  -> p::resource::package { 'puppet-agent':            }
  -> anchor               { 'p::agent::puppet::end':   }

}