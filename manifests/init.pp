class p {

  exec { 'apt-get update':
    command => "apt-get update -y --force-yes"
  }

  P::Resource::Apt::Repo <| |> -> Exec['apt-get update'] -> Package <| |>

}