Veewee::Session.declare({
  :cpu_count => '1',
  :memory_size=> '2048',
  :disk_size => '30720',
  :disk_format => 'VDI',
  :hostiocache => 'off',
  :os_type_id => 'RedHat_64',
  :iso_file => "SL-7.1-x86_64-netinst.iso",
  :iso_src => "http://ftp.heanet.ie/pub/rsync.scientificlinux.org/7.2/x86_64/iso/SL-7.2-x86_64-netinst.iso",
  :iso_shai => "7983b8dd597478cedf0a0f05294d35221bffddb7",
  :iso_download_timeout => 1200,
  :boot_wait => "16",
  :boot_cmd_sequence => [
    '<Tab> text ks=http://%IP%:%PORT%/ks.cfg<Enter>'
  ],
  :kickstart_port => "7122",
  :kickstart_timeout => 300,
  :kickstart_file => "ks.cfg",
  :ssh_login_timeout => "10800",
  :ssh_user => "vagrant",
  :ssh_password => "vagrant",
  :ssh_key => "",
  :ssh_host_port => "7222",
  :ssh_guest_port => "22",
  :sudo_cmd => "echo '%p' | sudo -S sh '%f'",
  :shutdown_cmd => "/sbin/halt -h -p",
  :postinstall_files => [
    "base.sh",
    "vagrant.sh",
    "repo-epel.sh",
    "repo-ius.sh",
    "ansible.sh",
    "virtualbox.sh",
    "cleanup.sh",
    "zerodisk.sh"
  ],
  :postinstall_timeout => 10800
})
