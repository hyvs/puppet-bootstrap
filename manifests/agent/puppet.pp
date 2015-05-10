class p::agent::puppet (
) {

  if !defined(Class['p::repo::puppetlabs']) {
    class {'p::repo::puppetlabs': }
  }

  anchor { 'p::agent::puppet::begin': }

  package { 'puppet':
    ensure  => 'installed',
    require => Anchor['p::agent::puppet::begin'],
    before  => Anchor['p::agent::puppet::end'],
  }

  augeas { "puppet agent settings":
    changes => [
    "set /files/etc/puppet/puppet.conf/agent/configtimeout 300",
    "set /files/etc/puppet/puppet.conf/agent/report true"
    ],
    require => Anchor['p::agent::puppet::begin'],
    before  => Anchor['p::agent::puppet::end'],
  }

  anchor { 'p::agent::puppet::end':
    require => Anchor['p::agent::puppet::begin'],
  }

}