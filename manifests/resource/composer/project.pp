define p::resource::composer::project (
  $dir  = $name,
  $user = 'root',
  $composer_home = '/root/.composer'
) {

  exec {"composer install ${dir}" :
    cwd     => $dir,
    user    => $user,
    environment => ["COMPOSER_HOME=${composer_home}"],
    command => "composer install --no-interaction",
  }

}
