Facter.add('redis_fact_version') do
  setcode do
    Facter::Util::Resolution.exec("/usr/bin/redis-server --version 2>&1 | sed '/^Redis server v=/s///' | cut -f 1 -d ' '")   || nil
  end
end
