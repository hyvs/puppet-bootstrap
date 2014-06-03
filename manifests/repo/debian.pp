class p::repo::debian (
) {

  anchor {'p::repo::debian::begin': } ->
  p::resource::apt::repo {'debian':
    location    => 'http://ftp.fr.debian.org/debian/',
    repos       => 'non-free',
  } ->
  anchor {'p::repo::debian::end': }

}