#!/usr/bin/env ruby
# Is RVM installed ?

#raise 'Must run as root' unless Process.uid == 0

def is_gem_installed dep
  require 'rubygems'
  begin
    Gem::Specification.find_by_name(dep)
    true
  rescue Gem::LoadError 
    false
  end
end

def install_ruby_gems_from_source
  puts 'Installing ruby gems from source'
  current = Dir.pwd()  
  begin
    Dir.chdir('/tmp')
    puts `curl -O http://production.cf.rubygems.org/rubygems/rubygems-1.8.10.tgz`
    puts `tar zxf rubygems-1.8.10.tgz`
    Dir.chdir('rubygems-1.8.10')
    puts `ruby setup.rb --no-format-executable`
  ensure
    Dir.chdir(current)
  end
end

if is_gem_installed('rvm')
  'rvm installed using system ruby'
  require 'rvm'
  RVM::use('system')
end

unless is_gem_installed('chef')
  install_ruby_gems_from_source 
  puts 'installing chef'
  puts `gem install chef --no-ri --no-rdoc` 
end



  