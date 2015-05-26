class p::tool::git (
  $package = 'git'
) {

  if !defined(P::Resource::Package[$package]) {
    p::resource::package {$package: }
  }

}