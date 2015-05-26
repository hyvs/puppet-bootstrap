class p::repo::debian (
) {

  p::resource::apt::repo { 'debian':
    location => 'http://ftp.fr.debian.org/debian/',
    repos    => 'non-free',
  }

}