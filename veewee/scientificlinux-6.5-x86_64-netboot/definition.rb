Veewee::Session.declare({
  :cpu_count => '2',
  :memory_size=> '2048',
  :disk_size => '30720',
  :disk_format => 'VDI',
  :hostiocache => 'off',
  :os_type_id => 'RedHat_64',
  :iso_file => "SL-6-x86_64-2014-11-05-netinstall.iso",
  :iso_src => "ftp://ftp.heanet.ie/pub/scientific/6/x86_64/iso/SL-6-x86_64-2014-11-05-netinstall.iso",
  :iso_shai => "ff79b8787ba0b8a61f09f169b8903ae0eb873ad3",
  :iso_download_timeout => 1200,
  :boot_wait => "24",
  :boot_cmd_sequence => [
    '<Tab> text ks=http://%IP%:%PORT%/ks.cfg<Enter>'
  ],
  :kickstart_port => "7122",
  :kickstart_timeout => 3600,
  :kickstart_file => "ks.cfg",
  :ssh_login_timeout => "3600",
  :ssh_user => "veewee",
  :ssh_password => "veewee",
  :ssh_key => "",
  :ssh_host_port => "7222",
  :ssh_guest_port => "22",
  :sudo_cmd => "echo '%p' | sudo -S sh '%f'",
  :shutdown_cmd => "/sbin/halt -h -p",
  :postinstall_files => [
    "base.sh",
    "epel.sh",
    "ruby.sh",
    "puppet.sh",
    "vagrant.sh",
    "virtualbox.sh",
    "cleanup.sh",
    "zerodisk.sh"
  ],
  :postinstall_timeout => 3600
})
