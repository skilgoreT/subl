TEMP_TARBALL = "/tmp/chef-solo/subl_2.0.1.tar.gz"
cookbook_file TEMP_TARBALL do
  source "subl_2.0.1.tar.gz"
  owner `whoami`.chomp
  group `groups`.split(/\s+/)[0]
  mode "0644"
end

execute "mkdir" do
  pkgdir = File.join(ENV['HOME'],'bin','pkg')
  creates pkgdir
  command "mkdir -p #{pkgdir}"
  notifies :run, "execute[inflate-tarball]"
end

execute "inflate-tarball" do
  command "tar xvzf #{TEMP_TARBALL} -C #{ENV['HOME']}/bin/pkg"
  notifies :run, "execute[make-links]"
end

execute "make-links" do
  if platform?("ubuntu")
    command "ln -sf #{ENV['HOME']}/bin/pkg/Sublime\\ Text\\ 2/sublime_text #{ENV['HOME']}/bin/subl"  
  elsif platform?("mac_os_x")
    command "ln -sf #{ENV['HOME']}/bin/pkg/Sublime\\ Text\\ 2.app/Contents/SharedSupport/bin/subl #{ENV['HOME']}/bin/subl"
  end
  action :nothing
end
  


