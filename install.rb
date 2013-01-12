#!/usr/bin/env ruby
# Is RVM installed ?

`killall Sublime\\ Text\\ 2`
Dir.chdir('kitchen')
cmd = "chef-solo -c solo.rb -j install.json"
puts cmd
puts `#{cmd}`

  