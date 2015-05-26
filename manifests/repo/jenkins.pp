class p::repo::jenkins (
) {

  p::resource::apt::repo { 'jenkins':
    location   => 'http://pkg.jenkins-ci.org/debian',
    release    => 'binary/',
    repos      => '',
    key        => '9B7D32F2D50582E6',
    key_source => 'http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key',
  }

}