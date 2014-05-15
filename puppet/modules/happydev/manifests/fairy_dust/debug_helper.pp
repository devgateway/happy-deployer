# = Class: happydev::fairy_dust::debug_helper
#
# @TODO: Extend this helper file.

class happydev::fairy_dust::debug_helper {
  if $::kernel == 'Linux' {
    $dump_file = '/tmp/facts.yaml'
    file { $dump_file:
      content => inline_template("<%= scope.to_hash.reject { |k,v| !( k.is_a?(String) && v.is_a?(String) ) }.to_yaml %>\n"),
    }

    info("Your facts have been saved to $dump_file!")
  }
}
