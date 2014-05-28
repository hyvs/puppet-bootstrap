define p::resource::mcollective::plugin (
  $ensure         = 'present',
  $plugin_type    = 'agent',
  $install_mode   = undef,
  $install_client = false,
  $ddl            = undef,
  $application    = undef
) {

  ::mcollective::plugin { $name:
    ensure         => $ensure,
    plugin_type    => $plugin_type,
    install_client => $install_client,
    install_mode   => $install_mode,
    application    => $application,
    ddl            => $ddl,
  }

}