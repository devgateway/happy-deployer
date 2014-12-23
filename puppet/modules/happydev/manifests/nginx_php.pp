# = Class: happydev::nginx_php
#
# == Requires:
# * http://forge.puppetlabs.com/puppetlabs/nginx
# * http://forge.puppetlabs.com/puppetlabs/firewall
# * http://forge.puppetlabs.com/example42/php
#
# == TODO:
# * Make it do something!
#

class happydev::nginx_php (
  $docroot = '',
  $domain  = '',
) {

  notify { 'Looks like you want to install Nginx... tough luck!': }

  # Setup iptables to allow access to the HTTP server.
  # firewall { '100 allow HTTP and HTTPS access':
  #   port => [80, 443],
  #   proto => tcp,
  #   action => accept,
  # }

  # @TODO: Test if web server is accessible from all IPs of the server!
  # file { "${docroot}/test.html":
  #   ensure  => file,
  #   content => 'The webserver works just fine!!!',
  #   group => 'vagrant',
  #   owner => 'vagrant',
  # }
}
