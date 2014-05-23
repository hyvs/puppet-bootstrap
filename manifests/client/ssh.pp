class p::client::ssh (
) {

  anchor {'p::client::ssh::begin': } ->
  p::resource::package {'openssh-client': } ->
  anchor {'p::client::ssh::end': }

}