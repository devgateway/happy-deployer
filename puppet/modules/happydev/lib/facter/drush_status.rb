
# Returns the status of Drush.

Facter.add('drush_status') do
  setcode do
    if File.exist?('/usr/bin/drush')
      'installed'
    else
      'missing'
    end
  end
end
