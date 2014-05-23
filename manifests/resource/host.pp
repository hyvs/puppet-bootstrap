define p::resource::host (
  $ip,
  $aliases = undef,
  $host    = $name
) {

  host {$host:
    ip           => $ip,
    host_aliases => $aliases,
  }

}