require_relative 'subl'

TEMP_TARBALL = "/tmp/chef-solo/subl_2.0.1.tar.gz"
SUBL_TAR = "subl_2.0.1.tar.gz"

cookbook_file TEMP_TARBALL do
  source SUBL_TAR
  owner `whoami`.chomp
  group `groups`.split(/\s+/)[0]
  mode "0644"
end

execute "mkdir" do
  pkgdir = File.join(ENV['HOME'],'bin','pkg')
  creates pkgdir
  Subl.with_logging("mkdir -p #{pkgdir}") 
#  command "mkdir -p #{pkgdir}"
  notifies :run, "execute[inflate-tarball]"
end

execute "inflate-tarball" do
  Subl.with_logging( "tar xvzf #{TEMP_TARBALL} -C #{ENV['HOME']}/bin/pkg")
  notifies :run, "execute[make-links]"
end

SUBL_DIR = "#{ENV['HOME']}/bin/pkg/Sublime\\ Text\\ 2"
SUBL_CLI = "#{ENV['HOME']}/bin/subl"
execute "make-links" do
  if platform?("ubuntu")
    Subl.with_logging( "ln -sf #{SUBL_DIR}/sublime_text #{SUBL_CLI}")
  elsif platform?("mac_os_x")
    Subl.with_logging( "ln -sf #{SUBL_DIR} #{ENV['HOME']}/Library/Application\\ Support/.")
    Subl.with_logging( "ln -sf #{SUBL_DIR}.app/Contents/SharedSupport/bin/subl #{SUBL_CLI}")
  end
  action :nothing
end

execute "install-gems" do
  Subl.with_logging( "gem install pry --no-ri --no-rdoc")
end
