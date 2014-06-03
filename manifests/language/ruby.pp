class p::language::ruby (
  $dirs         = hiera_hash('dirs'),
  $gem_resource = 'p::resource::ruby::gem',
  $gems         = hiera_hash('gems'),
  $ruby_ver     = undef,
  $system_user  = 'root',
  $version      = 'latest'
) {

  if undef != $ruby_ver {
    $ruby_version_string = $ruby_ver
  } else {
    $ruby_version_string = "ruby-${ruby_version}"
  }

  $gems_defaults = {
    require  => [Rvm_system_ruby[$ruby_version_string], Anchor['p::language::ruby::begin']],
    before   => Anchor['p::language::ruby::end'],
    ruby_ver => $ruby_version_string
  }

  anchor {'p::language::ruby::begin': } ->
  class {'::rvm':
    version => $version,
  } ->
  rvm::system_user {$system_user: } ->
  rvm_system_ruby {$ruby_version_string:
    ensure      => present,
    default_use => true,
    require     => Class['::rvm::system'],
  } ->
  anchor {'p::language::ruby::end': }

  create_resources($gem_resource, $gems, $gems_defaults)

}