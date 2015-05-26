class p::agent::ntp (
  $servers   = hiera_array('ntp_servers'),
  $restricts = hiera_array('ntp_restricts')
) {

     p::resource::package { 'ntp':                                                            }
  -> file                 { '/etc/ntp.conf':        content => template('p/ntp/ntp.conf.erb'), notify => Service['ntp'], }
  -> service              { 'ntp':                  ensure => 'running'                       }

}