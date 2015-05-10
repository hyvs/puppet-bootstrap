class p::language::java (
  $package      = hiera('java_package'),
  $distribution = 'jdk'
) {

  anchor {'p::language::java::begin': }

  class {'::java':
    package      => $package,
    distribution => $distribution,
    require      => Anchor['p::language::java::begin'],
    before       => Anchor['p::language::java::end'],
  }

  anchor {'p::language::java::end':
    require => Anchor['p::language::java::begin'],
  }

}