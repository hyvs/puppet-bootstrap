class p::agent::heka (
  $version           = hiera('heka_version', '0.10.0b2'),
  $base_url          = "https://github.com/mozilla-services/heka/releases/download",
  $debug             = hiera('heka_debug', false),
  $env               = hiera('heka_env', 'prod'),
  $server            = hiera('heka_server', 'prod'),
  $apps              = hiera_array('heka_apps', []),
  $streamer_inputs   = hiera_hash('heka_streamer_inputs', {}),
  $udp_inputs        = hiera_hash('heka_udp_inputs', {}),
  $es_server         = hiera('heka_es_server', 'http://127.0.0.1:9200'),
) {

  $nginx_log_format = $p::server::nginx::log_format

  $filename = $::architecture ? {
    /(i386|x86$)/    => "heka_${version}_i386",
    /(amd64|x86_64)/ => "heka_${version}_amd64",
  }

  $streamer_input_resource  = 'p::resource::heka::streamer_input'
  $streamer_inputs_defaults = {
    require => Package['heka'],
    notify  => Service['heka'],
  }

  $udp_input_resource  = 'p::resource::heka::udp_input'
  $udp_inputs_defaults = {
    require => Package['heka'],
    notify  => Service['heka'],
  }

  # Download heka package

  exec{'get_heka':
    command => "/usr/bin/wget -q ${base_url}/v${version}/${filename}.deb -O /tmp/${filename}.deb",
    creates => "/etc/heka"
  }

  # Install heka

  package { "heka":
    provider => dpkg,
    ensure => installed,
    source => "/tmp/${filename}.deb",
    require => Exec['get_heka'],
  }

  # Configure heka

  file { "/etc/heka/conf.d/00-hekad.toml":
    ensure  => 'file',
    content => template('p/heka/hekad.toml.erb'),
    require => Package['heka'],
    notify  => Service['heka'],
  }
  file { "/etc/heka/monolog_decoder.lua":
    ensure  => 'file',
    content => template('p/heka/monolog_decoder.lua.erb'),
    require => Package['heka'],
    notify  => Service['heka'],
  }
  file { "/etc/heka/severity_text_decoder.lua":
    ensure  => 'file',
    content => template('p/heka/severity_text_decoder.lua.erb'),
    require => Package['heka'],
    notify  => Service['heka'],
  }

  # config - heka common decoders
  file { "/etc/heka/conf.d/nginx_access_decoder.toml":
    ensure  => 'file',
    content => template('p/heka/nginx_access_decoder.toml.erb'),
    require => Package['heka'],
    notify  => Service['heka'],
  }
  file { "/etc/heka/conf.d/nginx_error_decoder.toml":
    ensure  => 'file',
    content => template('p/heka/nginx_error_decoder.toml.erb'),
    require => Package['heka'],
    notify  => Service['heka'],
  }
  file { "/etc/heka/conf.d/monolog_decoder.toml":
    ensure  => 'file',
    content => template('p/heka/monolog_decoder.toml.erb'),
    require => Package['heka'],
    notify  => Service['heka'],
  }
  file { "/etc/heka/conf.d/php_error_decoder.toml":
    ensure  => 'file',
    content => template('p/heka/php_error_decoder.toml.erb'),
    require => Package['heka'],
    notify  => Service['heka'],
  }
  file { "/etc/heka/conf.d/severity_text_decoder.toml":
    ensure  => 'file',
    content => template('p/heka/severity_text_decoder.toml.erb'),
    require => Package['heka'],
    notify  => Service['heka'],
  }

  # config - heka splitters
  file { "/etc/heka/conf.d/php_error_splitter.toml":
    ensure  => 'file',
    content => template('p/heka/php_error_splitter.toml.erb'),
    require => Package['heka'],
    notify  => Service['heka'],
  }

  # config - heka scribbles (inject static fields to each messages)
  file { "/etc/heka/conf.d/scribble_env.toml":
    ensure  => 'file',
    content => template('p/heka/scribble_env.toml.erb'),
    require => Package['heka'],
    notify  => Service['heka'],
  }
  file { "/etc/heka/conf.d/scribble_server.toml":
    ensure  => 'file',
    content => template('p/heka/scribble_server.toml.erb'),
    require => Package['heka'],
    notify  => Service['heka'],
  }
  file { "/etc/heka/conf.d/scribble_app.toml":
    ensure  => 'file',
    content => template('p/heka/scribble_app.toml.erb'),
    require => Package['heka'],
    notify  => Service['heka'],
  }

  # config - heka streamer inputs
  create_resources($streamer_input_resource, $streamer_inputs, $streamer_inputs_defaults)

  # config - heka udp inputs
  create_resources($udp_input_resource, $udp_inputs, $udp_inputs_defaults)

  # config - heka outputs
  file { "/etc/heka/conf.d/debug.toml":
    ensure  => 'file',
    content => template('p/heka/debug.toml.erb'),
    require => Package['heka'],
    notify  => Service['heka'],
  }
  file { "/etc/heka/conf.d/es.toml":
    ensure  => 'file',
    content => template('p/heka/es.toml.erb'),
    require => Package['heka'],
    notify  => Service['heka'],
  }

  # Start heka service

  service { 'heka':
    ensure  => running,
    enable  => true,
    require  => Package['heka'],
  }

}