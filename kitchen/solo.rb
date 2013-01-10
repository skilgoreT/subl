file_cache_path "/tmp/chef-solo"
cookbook_path File.expand_path(File.join(File.dirname(__FILE__),'cookbooks'))
# Very annoying but necessary override for non-privlidged user
Chef::Config[:cache_options]={:path=>"/tmp/chef-solo/checksums"}
