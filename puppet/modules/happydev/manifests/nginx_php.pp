# = Class: happydev::nginx_php
#
# == Requires:
#
# * 'puppetlabs/nginx', '>= 0.0.1'
#   @see http://forge.puppetlabs.com/puppetlabs/nginx
# * 'puppetlabs/firewall', '1.x'
#   @see http://forge.puppetlabs.com/puppetlabs/firewall
# * 'example42/php', '2.x'
#   @see http://forge.puppetlabs.com/example42/php
#
# == TODO:
#
# * Make it do something!
#

class happydev::nginx_php (
  $docroot = '',
  $domain = '',
) {

  notify { 'Looks like you want to install Nginx... tough luck, nobody bothered to try and set it up' : }

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
