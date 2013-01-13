  require File.expand_path(File.join(File.dirname(__FILE__), 'subl'))

  TEMP_TARBALL = "/tmp/subl_2.0.1.tar.gz"
  SUBL_TAR = "subl_2.0.1.tar.gz"

  ruby_block "install" do
   action :nothing
   block do
     Subl.with_logging(cmd = "tar xvzf #{TEMP_TARBALL} -C /tmp") {system cmd}
     if platform?("ubuntu")
       SUBL_USR = "sublime-text-2"
       SUBL_APP = "Sublime Text 2"
       TMP_SUBL_APP = File.join("", "tmp", SUBL_APP)
       TMP_SUBL_USR = File.join("", "tmp", SUBL_USR)
       tgt = File.join(ENV['HOME'], '.config', SUBL_USR)
     elsif platform?("mac_os_x")
       SUBL_USR = "Sublime Text 2"
       SUBL_APP = "Sublime Text 2.app"
       TMP_SUBL_APP = File.join("", "tmp", SUBL_APP)
       TMP_SUBL_USR = File.join("", "tmp", SUBL_USR)
       tgt = File.join(ENV['HOME'], 'Library', 'Application Support', SUBL_USR)
     end
     FileUtils.rm_rf(tgt) if Dir.exist?(tgt)    
     tgt = File.join('', 'Applications', SUBL_APP)
     FileUtils.rm_rf(tgt) if Dir.exist?(tgt)
     FileUtils.cp_r(TMP_SUBL_APP, tgt)
     installed_app = File.join("", "Applications", SUBL_APP, "Contents", "SharedSupport", "bin", "subl")
     FileUtils.ln_sf(installed_app, File.join(ENV['HOME'], "bin", "subl"))
     Subl.with_logging( cmd = "gem install pry --no-ri --no-rdoc") { system cmd }
   end
 end

 cookbook_file TEMP_TARBALL do
  source SUBL_TAR
  owner `whoami`.chomp
  group `groups`.split(/\s+/)[0]
  mode "0644"
  notifies :create, resources(:ruby_block => "install")
end


