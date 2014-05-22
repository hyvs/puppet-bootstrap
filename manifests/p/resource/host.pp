define p::resource::host (
  $ip
) {

  host {$name:
    ip => $ip,
  }

}