define p::resource::user (
$active               = true,
$email                = undef,
$aliases              = {},
$bash_logout_template = 'p/home/.bash_logout.erb',
$bashrc_template      = 'p/home/.bashrc.erb',
$custom_aliases       = undef,
$custom_profile       = undef,
$git_aliases          = undef,
$git_colors           = undef,
$gitconfig_template   = 'p/home/.gitconfig.erb',
$group                = undef,
$groups               = [],
$home                 = undef,
$keys                 = {},
$login                = $title,
$password             = undef,
$profile              = '',
$profile_template     = 'p/home/.profile.erb',
$prompt               = undef,
$public_key_resource  = 'p::resource::ssh::public_key',
$shell                = '/bin/bash',
$sudo                 = false,
$uid                  = undef
) {

  $empty_hash = {}

  if undef != $custom_aliases {
    $custom_aliases_list = $custom_aliases
  } else {
    $custom_aliases_list = hiera_hash("${login}_user_aliases", $empty_hash)
  }

  if undef != $custom_profile {
    $custom_profile_string = $custom_profile
  } else {
    $custom_profile_string = hiera("${login}_user_profile", '')
  }

  if undef != $git_aliases {
    $git_aliases_list = $git_aliases
  } else {
    $git_aliases_list = hiera_hash("${login}_user_git_aliases", $empty_hash)
  }

  if undef != $git_colors {
    $git_colors_list = $git_colors
  } else {
    $git_colors_list = hiera_hash("${login}_user_git_colors", $empty_hash)
  }

  validate_hash($custom_aliases_list)
  validate_string($custom_profile_string)
  validate_hash($aliases)
  validate_string($profile)
  validate_hash($keys)

  if undef != $home {
    $real_home = $home
  } else {
    $real_home = "/home/${login}"
  }

  if any2bool($active) {
    if any2bool($sudo) {
      $concated_groups = concat($groups, ['sudonopass'])
      $ugroups         = unique($concated_groups)
    } else {
      $ugroups = $groups
    }

    if undef == $group {
      fail("No group defined for system user ${login}")
    }

    user {$login:
      ensure     => 'present',
      comment    => $email ? {undef => $name, default => $name},
      uid        => $uid,
      gid        => $group,
      groups     => $ugroups,
      password   => $password,
      shell      => $shell,
      home       => $real_home,
      require    => Group[$group],
    } ->
    p::resource::directory {$real_home:
      recurse      => true,
      recurselimit => 1,
      owner        => $login,
      group        => $group,
    } ->
    p::resource::directory {"${real_home}/.ssh":
      owner   => $login,
      group   => $group,
      mode    => '0640',
    } ->
    file {"${real_home}/.gitconfig":
      ensure  => present,
      owner   => $login,
      group   => $group,
      content => template($gitconfig_template),
    }

    $default_public_key_params = {
      login   => $login,
      home    => $real_home,
      require => File["${real_home}/.gitconfig"],
    }

    $keys.each |$key_name, $key| {
      create_resources($public_key_resource, {"${login}_${key_name}" => $key}, $default_public_key_params)
    }

    file {"${real_home}/.profile":
      ensure  => file,
      content => template($profile_template),
      require => P::Resource::Directory[$real_home],
    } ->
    file {"${real_home}/.bashrc":
      ensure  => file,
      content => template($bashrc_template),
    } ->
    file {"${real_home}/.bash_logout":
      ensure  => file,
      content => template($bash_logout_template),
    }

  } else {

    user {$login:
      ensure  => absent,
    } ->
    file {$real_home:
      ensure  => absent,
      recurse => true,
    }

  }

}