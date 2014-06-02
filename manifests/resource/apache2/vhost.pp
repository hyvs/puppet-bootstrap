define p::resource::apache2::vhost (
  $docroot,
  $logs_dir,
  $common_template  = 'p/apache2/common.conf.erb',
  $user             = 'www-data',
  $group            = 'www-data',
  $public_dir       = undef,
  $domain           = $name,
  $env              = 'prod',
  $ip               = '*',
  $port             = 80,
  $priority         = '25',
  $setenvs          = undef,
  $setenvs_if       = [],
  $access_log       = 'access.log',
  $error_log        = 'error.log',
  $server_admin     = false,
  $server_aliases   = [],
  $options          = ['Indexes','FollowSymLinks','MultiViews'],
  $override         = ['None'],
  $directory_index  = '',
  $aliases          = undef,
  $rewrite_rules    = undef,
  $rewrite_conds    = undef,
  $ensure           = present,
  $request_headers  = undef,
  $directories      = undef,
  $expires          = undef
) {

  if undef != $directories {
    $real_directories = $directories
  } else {
    $real_directories = [ { path => $docroot } ]
  }

  if !defined(File[$docroot]) {
    file {$docroot:
      ensure  => directory,
      owner   => $user,
      group   => $group,
    }
  }

  $common_custom_fragment = template($common_template)

  apache::vhost { $domain:
    access_log      => true,
    access_log_file => $access_log,
    add_listen      => false,
    aliases         => $aliases,
    custom_fragment => "${common_custom_fragment}\n\n${custom_fragment}\n",
    directories     => $real_directories,
    directoryindex  => $directory_index,
    ensure          => $ensure,
    error_log       => true,
    error_log_file  => $error_log,
    ip              => $ip,
    docroot         => $docroot,
    logroot         => "${logs_dir}/${domain}",
    options         => $options,
    override        => $override,
    port            => $port,
    priority        => $priority,
    request_headers => $request_headers,
    rewrite_cond    => $rewrite_conds,
    rewrite_rule    => $rewrite_rules,
    setenv          => $setenvs,
    setenvif        => $setenvs_if,
    serveradmin     => $server_admin,
    serveraliases   => $server_aliases,
    servername      => $domain,
  }

}