define p::resource::heka::udp_input (
  $type,
  $address,
  $env = undef,
  $app = undef
) {

  file {"/etc/heka/conf.d/${name}.toml":
    content => template('p/heka/udp_input.erb'),
  }
}