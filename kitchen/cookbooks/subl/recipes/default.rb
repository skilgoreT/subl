require File.expand_path(File.join(File.dirname(__FILE__), 'subl'))

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
  Subl.with_logging(cmd = "mkdir -p #{pkgdir}") {command cmd}
#  command "mkdir -p #{pkgdir}"
  notifies :run, "execute[inflate-tarball]"
end

execute "inflate-tarball" do
  Subl.with_logging(cmd = "tar xvzf #{TEMP_TARBALL} -C #{ENV['HOME']}/bin/pkg") {command cmd}
#  notifies :run, "execute[make-links]"
end

SUBL_DIR = "#{ENV['HOME']}/bin/pkg/Sublime\\ Text\\ 2"
SUBL_CLI = "#{ENV['HOME']}/bin/subl"
execute "make-links" do
  if platform?("ubuntu")
    Subl.with_logging(cmd = "ln -sf #{SUBL_DIR}/sublime_text #{SUBL_CLI}") {command cmd}
  elsif platform?("mac_os_x")
    user_dir = "#{ENV['HOME']}/Library/Application\\ Support/Sublime\\ Text\\ 2"
    FileUtils.rm_rf(user_dir) if Dir.exist?(user_dir)
    FileUtils.ln_s(SUBL_DIR, user_dir)
    FileUtils.rm_f(SUBL_CLI)
    cli = "#{SUBL_DIR}.app/Contents/SharedSupport/bin/subl"
    FileUtils.ln_s(cli, SUBL_CLI)
  end
  action :nothing
end

execute "install-gems" do
  Subl.with_logging( cmd = "gem install pry --no-ri --no-rdoc") { command cmd }
end
