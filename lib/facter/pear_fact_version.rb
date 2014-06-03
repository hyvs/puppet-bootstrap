Facter.add('pear_fact_version') do
  setcode do
    Facter::Util::Resolution.exec("pear -V 2>&1 | sed '/^PEAR Version: /s///' | head -1")    || nil
  end
end
