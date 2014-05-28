class p::language::java (
  $package      = hiera('java_package'),
  $distribution = 'jdk'
) {

  anchor {'p::language::java::begin': } ->
  class {'::java':
    package      => $package,
    distribution => $distribution,
  } ->
  anchor {'p::language::java::end': }

}