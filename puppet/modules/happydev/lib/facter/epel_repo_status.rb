
# Returns the status of the EPEL repository.

Facter.add('epel_repo_status') do
  setcode do
    if File.exist?('/etc/yum.repos.d/epel.repo')
      # @TODO: Find a better way to determine the status of the EPEL repository.
      cmd = "yum repolist all | grep '^epel ' | sed 's/.*enabled:.*/repo-is-enabled/'"
      status = Facter::Util::Resolution.exec(cmd)
      if (status == 'repo-is-enabled')
        'enabled'
      else
        'disabled'
      end
    else
      'missing'
    end
  end
end
