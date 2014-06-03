Facter.add('apache_fact_version') do
  setcode do
    Facter::Util::Resolution.exec("/usr/sbin/apache2 -v 2>&1 | sed '/^Server version: /s///' | head -1 | cut -f 2 -d '/' |cut -f 1 -d '('")    || nil
  end
end
