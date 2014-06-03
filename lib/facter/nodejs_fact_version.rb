Facter.add('nodejs_fact_version') do
  setcode do
    Facter::Util::Resolution.exec("node -v| sed '/^v/s///'")    || nil
  end
end
