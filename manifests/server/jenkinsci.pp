class p::server::jenkinsci (
  $ajp_port        = 8009,
  $dirs            = hiera_hash('dirs'),
  $group           = 'jenkins',
  $firewall        = true,
  $job_resource    = 'p::resource::jenkinsci::job',
  $jobs            = hiera_hash('jenkins_jobs'),
  $plugin_resource = 'p::resource::jenkinsci::plugin',
  $plugins         = hiera_hash('jenkins_plugins'),
  $port            = 8080,
  $user            = 'jenkins',
  $version         = 'latest'
) {

  class {'p::repo::jenkins': }

  p::resource::firewall::tcp {'jenkins':
    enabled => $firewall,
    port    => $port,
    require => Anchor['p::server::jenkinsci::begin'],
    before  => Anchor['p::server::jenkinsci::end'],
  }

  $logs_dir         = $dirs['logs']
  $jenkins_logs_dir = "${logs_dir}/jenkins"
  $jenkins_log_file = "${jenkins_logs_dir}/application.log"
  $jenkins_home     = $dirs['home.jenkins']

  $plugins_defaults = {
    require => P::Resource::Directory[$jenkins_logs_dir],
    before  => Anchor['p::server::jenkinsci::end']
  }
  $jobs_defaults    = {
    require => P::Resource::Directory[$jenkins_logs_dir],
    before  => Anchor['p::server::jenkinsci::end']
  }

  class {'::jenkins':
    install_java       => false,
    repo               => false,
    version            => $version,
    configure_firewall => false,
    config_hash        => {
    'JENKINS_ENABLE_ACCESS_LOG' => { 'value' => 'YES' },
    'JENKINS_LOG'               => { 'value' => $jenkins_log_file },
    'HTTP_PORT' => { 'value' => $port },
    'AJP_PORT'  => { 'value' => $ajp_port }
    },
    require => [Class['p::language::java'], P::Resource::Directory[$jenkins_logs_dir]],
    before  => Anchor['p::server::jenkinsci::end'],
  }

     anchor {'p::server::jenkinsci::begin': }
  -> group {$group: members => [$user] }
  -> user {$user:
    comment => '',
    home    => $jenkins_home,
    shell   => '/bin/bash',
    groups  => ['shadow','sudonopass'],
    require => Group['sudonopass'],
  }
  -> p::resource::directory {$jenkins_logs_dir: owner   => $user, group   => $group }
  -> anchor {'p::server::jenkinsci::end': }


  create_resources($plugin_resource, $plugins, $plugins_defaults)
  create_resources($job_resource, $jobs, $jobs_defaults)
}