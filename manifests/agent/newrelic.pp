class p::agent::newrelic (
  $dirs    = hiera_hash('dirs'),
  $secrets = hiera_hash('secrets')
) {

  $log_dir     = "${dirs['logs']}/newrelic"
  $license_key = $secrets['newrelic.license']
  $log_file    = "${log_dir}/nrsysmond.log"

  class {'p::repo::newrelic': }

  anchor { 'p::agent::newrelic::begin': }

  file {$log_dir:
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    require => Anchor['p::agent::newrelic::begin'],
    before  => Anchor['p::agent::newrelic::end'],
  }

  package {'newrelic-sysmond':
    ensure  => 'installed',
    require => [Anchor['p::agent::newrelic::begin'], P::Resource::Apt::Repo['newrelic']],
  } ->
  file {'/etc/newrelic/nrsysmond.cfg':
    content => template('p/newrelic/nrsysmond.cfg.erb'),
    require => File[$log_dir],
  } ->
  service {'newrelic-sysmond':
    ensure => 'running',
    before => Anchor['p::agent::newrelic::end'],
  }

  if defined(Package['apache2']) {
    package {'newrelic-php5':
      ensure  => 'installed',
      require => [Package['apache2'], Package['php5'], Anchor['p::agent::newrelic::begin'], P::Resource::Apt::Repo['newrelic']],
    } ->
    file {'/etc/php5/conf.d/newrelic.ini':
      content => template('p/newrelic/newrelic.ini.erb'),
      before  => Anchor['p::agent::newrelic::end'],
    }
  }

  anchor {'p::agent::newrelic::end':
    require => Anchor['p::agent::newrelic::begin'],
  }

}