  require File.expand_path(File.join(File.dirname(__FILE__), 'subl'))

  SUBL_TAR = "subl_2.0.1.tgz"
  SUBL_USR_TAR = "subl_usr.tgz"
  FILES_DIR = File.expand_path(File.join(File.dirname(__FILE__),'../files'))
  USR_TARBALL = File.join(FILES_DIR, 'default', SUBL_USR_TAR)
  TEMP_TARBALL = "/tmp/#{SUBL_TAR}"

  ruby_block "install" do
   action :nothing
   block do
     Subl.with_logging(cmd = "tar xvzf #{TEMP_TARBALL} -C /tmp") {system cmd}
     if platform?("ubuntu")
       # App
       SUBL_APP = "Sublime Text 2"
       TMP_SUBL_APP = File.join("", "tmp", SUBL_APP)
       APP_TGT = File.join(ENV['HOME'], 'bin', SUBL_APP)
       APP = File.join(APP_TGT,'sublime_text')
       # User Data
       USR_TGT = File.join(ENV['HOME'], '.config', 'sublime-text-2')
     elsif platform?("mac_os_x")
       # App
       SUBL_APP = "Sublime Text 2.app"
       TMP_SUBL_APP = File.join("", "tmp", SUBL_APP)
       APP_TGT = File.join('', 'Applications', SUBL_APP)
       APP = File.join("", "Applications", SUBL_APP, "Contents", "SharedSupport", "bin", "subl")
       # User Data
       USR_TGT = File.join(ENV['HOME'], 'Library', 'Application Support', 'Sublime Text 2')
     end
     # User Data
     FileUtils.rm_rf(File.join(USR_TGT)) if Dir.exist?(USR_TGT)
     FileUtils.mkdir(USR_TGT)
     # Need to escape spaces in string before feeding to TAR
     target = USR_TGT.gsub(/(\s)/, "\\ ")
     Subl.with_logging(cmd = "tar xvzf #{USR_TARBALL} -C #{target} .") {system cmd}
     # App
     FileUtils.rm_rf(APP_TGT) if Dir.exist?(APP_TGT)    
     FileUtils.cp_r(TMP_SUBL_APP, APP_TGT)
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


