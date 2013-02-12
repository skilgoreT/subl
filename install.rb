#!/usr/bin/env ruby
# Is RVM installed ?


`killall Sublime\\ Text\\ 2` if RUBY_PLATFORM=~/darwin/
`killall subl` if RUBY_PLATFORM=~/linux/
Dir.chdir('kitchen')
cmd = "chef-solo -c solo.rb -j install.json"
puts cmd
puts `#{cmd}`

  