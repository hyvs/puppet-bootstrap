class p::repo::elasticsearch (
) {

  p::resource::apt::repo { 'elasticsearch':
    location   => 'http://packages.elasticsearch.org/elasticsearch/1.6/debian',
    release    => 'stable',
    repos      => 'main',
    key        => 'D27D666CD88E42B4',
    key_server => 'https://packages.elasticsearch.org/GPG-KEY-elasticsearch',
  }

}