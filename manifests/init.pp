class p (
) {

  stage {'repos':
    before => Stage['firewall'],
  }

}