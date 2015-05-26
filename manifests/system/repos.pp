class p::system::repos (
  $repos         = hiera_hash('repos'),
  $repo_resource = 'p::resource::apt::repo'
) {

  create_resources($repo_resource, $repos)

}