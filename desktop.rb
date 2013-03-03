#!/usr/bin/env ruby
# Is RVM installed ?


Dir.chdir('kitchen')
cmd = "chef-solo -c solo.rb -j desktop.json"
puts cmd
puts `#{cmd}`

  