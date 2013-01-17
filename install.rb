#!/usr/bin/env ruby
# Is RVM installed ?

q = `killall -q Sublime\\ Text\\ 2`
q = `killall -q subl`
Dir.chdir('kitchen')
cmd = "chef-solo -c solo.rb -j install.json"
puts cmd
puts `#{cmd}`

  