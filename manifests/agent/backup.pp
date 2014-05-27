class p::agent::backup (

) {

  anchor {'p::agent::backup::begin': }

  p::resource::package {'nfs-common':
    require => Anchor['p::agent::backup::begin'],
    before  => Anchor['p::agent::backup::end'],
  }

  file {'/root/bin':
    ensure => directory,
  }

  file {'/backups':
    ensure => directory,
    require => Anchor['p::agent::backup::begin'],
  }

  file {'/root/bin/backup-daily.sh':
    ensure  => file,
    mode    => 700,
    content => template('p/backup/daily.sh.erb'),
    require => [File['/root/bin'], File['/backups'], Anchor['p::agent::backup::begin']],
    before  => Anchor['p::agent::backup::end'],
  }

  file {'/root/bin/backup-evening.sh':
    ensure  => file,
    mode    => 700,
    content => template('p/backup/evening.sh.erb'),
    require => [File['/root/bin'], File['/backups'], Anchor['p::agent::backup::begin']],
    before  => Anchor['p::agent::backup::end'],
  }

  file {'/root/bin/backup-hourly.sh':
    ensure  => file,
    mode    => 700,
    content => template('p/backup/hourly.sh.erb'),
    require => [File['/root/bin'], File['/backups'], Anchor['p::agent::backup::begin']],
    before  => Anchor['p::agent::backup::end'],
  }

  file {'/root/bin/backup-mid-day.sh':
    ensure  => file,
    mode    => 700,
    content => template('p/backup/mid-day.sh.erb'),
    require => [File['/root/bin'], File['/backups'], Anchor['p::agent::backup::begin']],
    before  => Anchor['p::agent::backup::end'],
  }

  file {'/root/bin/backup-morning.sh':
    ensure  => file,
    mode    => 700,
    content => template('p/backup/morning.sh.erb'),
    require => [File['/root/bin'], File['/backups'], Anchor['p::agent::backup::begin']],
    before  => Anchor['p::agent::backup::end'],
  }

  file {'/root/bin/backup-night.sh':
    ensure  => file,
    mode    => 700,
    content => template('p/backup/night.sh.erb'),
    require => [File['/root/bin'], File['/backups'], Anchor['p::agent::backup::begin']],
    before  => Anchor['p::agent::backup::end'],
  }

  anchor {'p::agent::backup::end':
    require => Anchor['p::agent::backup::begin'],
  }

}