define p::resource::heka::streamer_input (
  $type,
  $directory,
  $file,
  $env = undef,
  $app = undef,
  $splitter = undef
) {

  file {"/etc/heka/conf.d/${name}.toml":
    content => template('p/heka/streamer_input.erb'),
  }
}