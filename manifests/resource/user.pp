define p::resource::user (
  $email  = undef,
  $groups = {}
) {

  user {$name:
    comment => $email ? {undef => $name, default => $email},
    groups => $groups,
  }

}