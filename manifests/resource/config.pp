define p::resource::config (
  $value,
  $file
) {

  augeas { "${file}/${name}/${value}":
    context => "/files/${file}",
    changes => [
    "set ${name} ${value}"
    ],
  }

}
