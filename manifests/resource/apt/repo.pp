define p::resource::apt::repo (
  $location,
  $repos,
  $release,
  $key        = undef,
  $key_server = undef,
  $pin        = undef,
  $src        = false
) {

  file { "/etc/apt/sources.list.d/${name}": content => template('p/apt/repo.list.erb')}

  if $key_server {
    exec { "download key ${key_server}":
      command => "wget -q -O - ${key_server} && sudo apt-key add -",
      before  => File["/etc/apt/sources.list.d/${name}"],
    }
  }

}