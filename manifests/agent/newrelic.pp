class p::agent::newrelic (
 $license_key = hiera('newrelic_license_key')
) {

  if !defined(Class['p::repo::newrelic']) {
    class {'p::repo::newrelic': }
  }

  $log_dir     = '/var/log/newrelic'
  $log_file    = '/var/log/newrelic/nrsysmond.log'

     p::resource::directory { $log_dir:                                             }
  -> p::resource::package   { 'newrelic-sysmond':            ensure  => 'installed' }
  -> file                   { '/etc/newrelic/nrsysmond.cfg': content => template('p/newrelic/nrsysmond.cfg.erb') }
  -> service                { 'newrelic-sysmond':            ensure => 'running'    }

}