#!/usr/bin/env ruby

require 'rubygems'

def which?(name)
  `which #{name}`
  $?.success?
end

unless which?('rvm')
  puts 'please install RVM before running bootstrap'
else  
  require 'rvm'
  RVM::use('default')
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
install_ruby_gems_from_source 

def is_gem_installed dep
  require 'rubygems'
  begin
    Gem::Specification.find_by_name(dep)
    true
  rescue Gem::LoadError 
      false
  end
end

unless is_gem_installed('chef')  
  puts 'installing chef'
  puts `gem install chef --no-ri --no-rdoc` 
end

unless is_gem_installed('ptools')  
  puts 'installing ptools'
  puts `gem install ptools --no-ri --no-rdoc` 
end



  