define p::resource::file (
  $owner   = 'root',
  $group   = 'root',
  $mode    = undef,
  $content = ''
) {

  file {$name:
    ensure  => 'file',
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => $content,
  }

}