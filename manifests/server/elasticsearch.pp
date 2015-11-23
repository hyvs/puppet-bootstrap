class p::server::elasticsearch (
  $firewall      = true,
  $port          = 9200,
  $repo_version  = hiera('elasticsearch_repo_version', undef),
  $version       = hiera('elasticsearch_version', undef),
  $data_dir      = hiera('elasticsearch_data_dir', '/var/lib/elasticsearch/data'),
  $listen_only   = hiera('elasticsearch_listen_only', undef),
) {

  if !defined(Class['p::repo::elasticsearch']) {
    class {'p::repo::elasticsearch': version => $repo_version }
  }

     p::resource::package       { 'openjdk-7-jre': }
  -> p::resource::package       { 'elasticsearch': version => $version }
  -> p::resource::firewall::tcp { 'elasticsearch': enabled => $firewall, port => $port }
  -> p::resource::directory     { "${data_dir}": owner => 'elasticsearch', group => 'elasticsearch', recurse => true }
  -> service                    { 'elasticsearch': ensure => 'running', enable => true }

  file_line { 'elasticsearch change listen port':
    require => [P::Resource::Package['elasticsearch']],
    path    => '/etc/elasticsearch/elasticsearch.yml',
    line    => " http.port: ${port}",
    match   => '^(\#)? http.port\:',
    notify   => Service['elasticsearch'],
  }

  if ($listen_only) {
    file_line { 'elasticsearch enable listen on specified interfaces':
      require => [P::Resource::Package['elasticsearch']],
      path    => '/etc/elasticsearch/elasticsearch.yml',
      line    => " network.host: ${listen_only}",
      match   => '^(\#)? network.host\:',
      notify   => Service['elasticsearch'],
    }
  }

  if ($data_dir) {
    file_line { 'elasticsearch change data directory':
      require => [P::Resource::Package['elasticsearch']],
      path    => '/etc/elasticsearch/elasticsearch.yml',
      line    => " path.data: ${data_dir}",
      match   => '^(\#)? path.data\:',
      notify   => Service['elasticsearch'],
    }
  }

}