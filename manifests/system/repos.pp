class p::system::repos (
  $repo_resource = 'p::resource::apt::repo',
  $repos         = hiera_hash('repos')
) {

  $repos_defaults = {
    require => Anchor['p::system::repos::begin'],
    before  => Anchor['p::system::repos::end']
  }

  anchor {'p::system::repos::begin': } ->
  anchor {'p::system::repos::end': }

  create_resources($repo_resource, $repos, $repos_defaults)

}