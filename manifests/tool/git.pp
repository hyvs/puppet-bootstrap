class p::tool::git (
  $package = 'git'
) {

  if !defined(P::Resource::Package[$package]) {
    p::resource::package {$package:
      require  => Anchor['p::tool::git::begin'],
      before   => Anchor['p::tool::git::end'],
    }
  }

     anchor { 'p::tool::git::begin': }
  -> anchor { 'p::tool::git::end':   }

}