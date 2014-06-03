Facter.add('mysql_fact_version') do
  setcode do
    Facter::Util::Resolution.exec("mysql --version | cut -f 6 -d ' ' | cut -d ',' -f 1") || nil
  end
end
