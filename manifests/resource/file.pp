define p::resource::file (
  $group           = 'root',
  $mode            = '0755',
  $path            = $name,
  $owner           = 'root',
  $content         = undef,
  $template        = undef,
  $inline_template = undef,
  $vars            = $::empty_hash
) {

  if undef != $template {
    $real_content = template($template)
  } else {
    if undef != $inline_template {
      $real_content = inline_template($inline_template)
    } else {
      $real_content = $content
    }
  }

  file {$name:
    ensure  => file,
    group   => $group,
    mode    => $mode,
    owner   => $owner,
    path    => $path,
    content => $real_content,
  }

}