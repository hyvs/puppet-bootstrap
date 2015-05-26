define p::resource::apt::repo (
  $location,
  $repos,
  $release,
  $key        = undef,
  $key_server = undef,
  $pin        = undef,
  $src        = false
) {

     anchor { "p::resource::apt::repo::begin::${name}": }
  -> file { "/etc/apt/sources.list.d/${name}": content => template('p/apt/repo.list.erb')}
  -> anchor { "p::resource::apt::repo::end::${name}": }

  if $key_server {
    exec { "download key ${key_server}":
      command => "wget -q -O - ${key_server} && sudo apt-key add -",
      require => Anchor["p::resource::apt::repo::begin::${name}"],
      before  => File["/etc/apt/sources.list.d/${name}"],
    }
  }

}