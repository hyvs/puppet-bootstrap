define p::resource::php::directive (
  $entry,
  $value,
  $directive = $name
) {

  php::augeas {"php-apache2-${name}":
    require => Class['::php'],
    notify  => Service[$::php::service],
    target  => '/etc/php5/apache2/php.ini',
    entry   => $entry,
    value   => $value;
  } ->
  php::augeas {"php-cli-${name}":
    require => Class['::php'],
    notify  => Service[$::php::service],
    target  => '/etc/php5/cli/php.ini',
    entry   => $entry,
    value   => $value;
  }

}