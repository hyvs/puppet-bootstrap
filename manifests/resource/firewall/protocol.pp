define p::resource::firewall::protocol (
  $enabled = true,
  $action  = 'accept',
  $rule_name = undef
) {

  if $enabled and defined('::firewall') {

    if !$rule_name {
      $full_description = "010 ${action} protocol ${name}"
    } else {
      $full_description = $rule_name
    }

    firewall { $full_description:
      action => $action,
      proto  => $name
    }

  }

}