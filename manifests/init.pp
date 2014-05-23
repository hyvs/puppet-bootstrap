class p (
) {

  stage {'repos':
    before => Stage['firewall'],
  }

  stage {'firewall':
    before => Stage['main'],
  }

  Stage['repos'] -> Stage['firewall'] -> Stage['main']

}