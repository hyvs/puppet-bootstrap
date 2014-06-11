define p::resource::jenkinsci::job (
  $config,
  $group        = 'jenkins',
  $home         = '/var/lib/jenkins',
  $package      = 'jenkins',
  $service      = 'jenkins',
  $type         = 'generic',
  $user         = 'jenkins'
) {

  validate_hash($config)

  $jenkins_jobs_dir = "${home}/jobs"
  $job_name         = $name
  $job_dir          = "${jenkins_jobs_dir}/${job_name}"
  $config_file      = "${job_dir}/config.xml"
  $template_file    = "p/jenkins/jobs/${type}-config.xml.erb"

  p::resource::directory {$job_dir:
    owner  => 'jenkins',
    group  => 'jenkins',
  } ->
  file {$config_file:
    replace => no,
    content => template($template_file),
    owner   => $user,
    group   => $group,
    require => [Package[$package], File[$job_dir]],
    notify  => Service[$service],
  }

}