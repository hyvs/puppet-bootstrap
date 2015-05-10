class p::system::locales (
  $lang     = hiera('lang'),
  $locales  = hiera_array('locales'),
  $timezone = hiera('timezone')
) {

  anchor {'p::system::locales::begin': }
  -> package { 'locales':
    ensure  => 'installed',
  }
  -> file { 'locales.conf':
    ensure  => 'present',
    path    => '/etc/locale.gen',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('p/locales/locale.gen.erb'),
    replace => true,
  }
  -> exec { 'generate_locales':
    command     => '/usr/sbin/locale-gen',
    refreshonly => true,
    subscribe   => File['locales.conf'],
  }
  -> exec {'change_default_locale':
    command => "sudo update-locale LANGUAGE=${lang} LANG=${lang}",
  }
  -> exec { 'change_default_locale_LC_ALL':
    command => "sudo update-locale LC_ALL=''; export LC_ALL=''",
  }
  -> file { 'timezone':
    ensure  => 'present',
    path    => '/etc/timezone',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => $timezone,
    replace => true,
  }
  -> exec { 'set-timezone':
    command     => 'dpkg-reconfigure -f noninteractive tzdata',
    path        => '/usr/bin:/usr/sbin:/bin:/sbin',
    subscribe   => File['timezone'],
    refreshonly => true,
  }
  -> anchor {'p::system::locales::end': }
  
}