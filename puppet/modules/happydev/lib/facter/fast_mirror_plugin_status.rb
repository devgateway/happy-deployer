
# Returns the status of the fastestmirror yum plugin.

Facter.add('fast_mirror_plugin_status') do
  setcode do
    if File.exist?('/etc/yum/pluginconf.d/fastestmirror.conf')
      'installed'
    else
      'missing'
    end
  end
end
