class p::server::kibana (
  $firewall          = hiera('kibana_firewall', true),
  $port              = hiera('kibana_port', 5601),
  $version           = hiera('kibana_version', '4.2.1'),
  $user              = hiera('kibana_user', 'kibana'),
  $group             = hiera('kibana_group', 'kibana'),
  $base_url          = "https://download.elastic.co/kibana/kibana",
  $install_path      = hiera('kibana_install_path', '/opt'),
  $elasticsearch_url = hiera('kibana_elasticsearch_url', 'http://localhost:9200'),
) {

  $filename = $::architecture ? {
    /(i386|x86$)/    => "kibana-${version}-linux-x86",
    /(amd64|x86_64)/ => "kibana-${version}-linux-x64",
  }

  # Configure firewall

  if !defined(P::Resource::Firewall::Tcp['kibana']) {
    p::resource::firewall::tcp {'kibana':
      enabled => $firewall,
      port    => $port,
    }
  }

  # Create user and group

  group { $group:
    ensure => 'present',
    system => true,
  }

  user { $user:
    ensure  => 'present',
    system  => true,
    gid     => $group,
    home    => $install_path,
    require => Group[$group],
  }

  # Download and extract kibana archive

  exec{'get_kibana':
    command => "/usr/bin/wget -q ${base_url}/${filename}.tar.gz -O /tmp/${filename}.tar.gz",
    creates => "${install_path}/kibana",
    require => User[$user],
  }

  exec { 'extract_kibana':
    command => "tar -xzf /tmp/${filename}.tar.gz -C ${install_path}",
    path    => ['/bin', '/sbin'],
    creates => "${install_path}/${filename}",
    notify  => Exec['ensure_correct_permissions'],
    require => Exec['get_kibana'],
  }

  exec { 'ensure_correct_permissions':
    command     => "chown -R ${user}:${group} ${install_path}/${filename}",
    path        => ['/bin', '/sbin'],
    refreshonly => true,
    require     => [
        Exec['extract_kibana'],
        User[$user],
    ],
  }

  file { "${install_path}/kibana":
    ensure  => 'link',
    target  => "${install_path}/${filename}",
    require => Exec['extract_kibana'],
  }

  file { '/var/log/kibana':
    ensure  => directory,
    owner   => "${user}",
    group   => "${group}",
    require => User['kibana'],
  }

  # Configure kibana

  file { "${install_path}/kibana/config/kibana.yml":
    ensure  => 'file',
    owner   => "${user}",
    group   => "${group}",
    mode    => '0440',
    content => template('p/kibana/kibana.yml.erb'),
    notify  => Service['kibana'],
  }

  # Start kibana service

  file { 'kibana-init-script':
    ensure  => file,
    path    => '/etc/systemd/system/kibana.service',
    content => template('p/kibana/kibana.service.erb'),
    notify  => Service['kibana'],
  }

  service { 'kibana':
    ensure  => running,
    enable  => true,
    provider => systemd,
    require  => File['kibana-init-script'],
  }

}
