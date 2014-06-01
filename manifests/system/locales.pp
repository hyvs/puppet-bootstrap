class p::system::locales (
  $lang     = hiera('lang'),
  $locales  = hiera_array('locales'),
  $timezone = hiera('timezone')
) {

  anchor {'p::system::locales::begin': }

  class { '::locales':
    locales => $locales,
    require => Anchor['p::system::locales::begin'],
  } ->
  exec {'change_default_locale':
    command => "sudo update-locale LANGUAGE=${lang} LANG=${lang}",
  } ->
  exec { 'change_default_locale_LC_ALL':
    command => "sudo update-locale LC_ALL=''; export LC_ALL=''",
    before   => Anchor['p::system::locales::end'],
  }

  class {'::timezone':
    timezone => $timezone,
    require  => Anchor['p::system::locales::begin'],
    before   => Anchor['p::system::locales::end'],
  }

  anchor {'p::system::locales::end':
    require => Anchor['p::system::locales::begin'],
  }
  
}