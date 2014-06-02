define p::resource::composer::project (
  $dir,
  $user = 'root'
) {

  exec {"composer install ${dir}" :
    cwd     => $dir,
    user    => $user,
    command => "composer install --no-interactive",
  }

}
