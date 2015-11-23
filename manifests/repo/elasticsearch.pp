class p::repo::elasticsearch (
  $version = '1.6'
) {

  p::resource::apt::repo { 'elasticsearch':
    location   => "http://packages.elastic.co/elasticsearch/${version}/debian",
    release    => 'stable',
    repos      => 'main',
    key        => 'D88E42B4',
    key_server => 'https://packages.elasticsearch.org/GPG-KEY-elasticsearch',
  }

}