class p::repo::jenkins (
) {

  anchor {'p::repo::jenkins::begin': } ->
  p::resource::apt::repo {'jenkins':
    location    => 'http://pkg.jenkins-ci.org/debian',
    release     => 'binary/',
    repos       => '',
    key         => 'D50582E6',
    key_source  => 'http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key',
    include_src => false,
  } ->
  anchor {'p::repo::jenkins::end': }

}