define p::resource::config (
  $value,
  $file
) {

  augeas { $config:
    context => "/files/${file}",
    changes => [
    "set ${name} ${value}"
    ],
  }

}
