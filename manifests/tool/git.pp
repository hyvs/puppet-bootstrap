class p::tool::git (
  $repository_resource = 'p::resource::git::repository',
  $repositories        = hiera_hash('git_repos')
) {

  $repositories_defaults = {
    require  => Anchor['p::tool::git::begin'],
    before   => Anchor['p::tool::git::end']
  }

  anchor {'p::tool::git::begin': } ->
  anchor {'p::tool::git::end': }

  create_resources($repository_resource, $repositories, $repositories_defaults)

}