  require File.expand_path(File.join(File.dirname(__FILE__), 'subl'))

  TEMP_TARBALL = "/tmp/subl_2.0.1.tgz"
  TEMP_USR_TARBALL = "/tmp/subl_usr.tgz"
  SUBL_TAR = "subl_2.0.1.tgz"
  SUBL_USR_TAR = "subl_usr.tgz"
  
  ruby_block "install" do
   action :nothing
   block do
     Subl.with_logging(cmd = "tar xvzf #{TEMP_TARBALL} -C /tmp") {system cmd}
     if platform?("ubuntu")
       SUBL_USR = "sublime-text-2"
       SUBL_APP = "Sublime Text 2"
       TMP_SUBL_APP = File.join("", "tmp", SUBL_APP)
       TMP_SUBL_USR = File.join("", "tmp", SUBL_USR)
       APP_TGT = File.join(ENV['HOME'], 'bin', SUBL_APP)
       USR_TGT = File.join(ENV['HOME'], '.config', SUBL_USR)
       APP = File.join(APP_TGT,'sublime_text')
     elsif platform?("mac_os_x")
       SUBL_USR = "Sublime Text 2"
       SUBL_APP = "Sublime Text 2.app"
       TMP_SUBL_APP = File.join("", "tmp", SUBL_APP)
       TMP_SUBL_USR = File.join("", "tmp", SUBL_USR)
       APP_TGT = File.join('', 'Applications', SUBL_APP)
       USR_TGT = File.join(ENV['HOME'], 'Library', 'Application Support', SUBL_USR)
       APP = File.join("", "Applications", SUBL_APP, "Contents", "SharedSupport", "bin", "subl")
     end
     FileUtils.rm_rf(APP_TGT) if Dir.exist?(APP_TGT)    
     FileUtils.cp_r(TMP_SUBL_APP, APP_TGT)
     FileUtils.rm_rf(USR_TGT) if Dir.exist?(USR_TGT)    
     FileUtils.cp_r(TMP_SUBL_USR, USR_TGT)
     FileUtils.ln_sf(APP, File.join(ENV['HOME'], "bin", "subl"))
     # Ruby support for SublimeREPL
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

cookbook_file TEMP_USR_TARBALL do
  source SUBL_TAR
  owner `whoami`.chomp
  group `groups`.split(/\s+/)[0]
  mode "0644"
  notifies :create, resources(:ruby_block => "install")
end


