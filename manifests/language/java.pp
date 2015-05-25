class p::language::java (
  $package = 'openjdk-8-jre-headless'
) {

     anchor               { 'p::language::java::begin': }
  -> p::resource::package { $package:                   }
  -> anchor               { 'p::language::java::end':   }

}