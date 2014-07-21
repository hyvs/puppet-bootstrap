define p::resource::config (
  $value,
  $file
) {

  if $value =~ /\s+/ {
    $real_value = "\"'${value}'\""
  }
  augeas { "${file}/${name}/${value}":
    context => "/files/${file}",
    changes => [
    "set ${name} ${real_value}"
    ],
  }

}
