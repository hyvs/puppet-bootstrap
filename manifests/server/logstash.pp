class p::server::logstash (
  $version  = undef
) {

  if !defined(Class['p::repo::logstash']) {
    class {'p::repo::logstash': }
  }

   p::resource::package { 'logstash': version => $version }

}