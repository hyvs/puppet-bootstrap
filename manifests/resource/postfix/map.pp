define p::resource::postfix::map (
  $maps
) {

  ::postfix::map { $name:
    maps => $maps,
  }

}