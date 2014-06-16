define p::resource::file (
  $group           = 'root',
  $mode            = '0755',
  $path            = $name,
  $owner           = 'root',
  $content         = undef,
  $template        = undef,
  $inline_template = undef,
  $vars            = undef,
  $require_file    = undef,
  $require_dir     = undef
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

  if undef != $require_file {
    File[$require_file] -> File[$name]
  }

  if undef != $require_dir {
    File[$require_dir] -> File[$name]
  }

}