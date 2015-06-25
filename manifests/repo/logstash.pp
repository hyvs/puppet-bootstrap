class p::repo::logstash (
) {

  p::resource::apt::repo { 'logstash':
    location   => 'http://packages.elasticsearch.org/logstash/1.5/debian',
    release    => 'stable',
    repos      => 'main',
    key        => 'D27D666CD88E42B4',
    key_server => 'https://packages.elasticsearch.org/GPG-KEY-elasticsearch',
  }

}