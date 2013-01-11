require File.expand_path(File.join(File.dirname(__FILE__), 'subl'))

SUBL_TAR = "subl_2.0.1.tar.gz"
FILES_DIR = File.expand_path(File.join(File.dirname(__FILE__),'../files'))

execute "tar-app" do
  if platform?("ubuntu")
    dir = File.join(FILES_DIR, 'ubuntu')
    Subl.with_logging(cmd = "tar cvfz #{File.join(dir,SUBL_TAR)} #{SUBL_DIR}.app #{SUBL_DIR}") { command cmd }
  elsif platform?("mac_os_x")
    dir = File.join(FILES_DIR, 'mac_os_x')
    app_dir = '/Applications'
    Subl.with_logging(cmd = "tar cvfz #{File.join(dir,SUBL_TAR)} -C #{app_dir} Sublime\\ Text\\ 2.app") {command cmd}
  end
  notifies :run, "execute[tar-user]"
end

execute "tar-user" do
  if platform?("ubuntu")
    dir = File.join(FILES_DIR, 'ubuntu')
    Subl.with_logging(cmd = "tar cvfz #{File.join(dir,SUBL_TAR)} #{SUBL_DIR}.app #{SUBL_DIR}") { command cmd }
  elsif platform?("mac_os_x")
    dir = File.join(FILES_DIR, 'mac_os_x')
    user_dir = File.join(ENV['HOME'], 'Library', 'Application\\ Support')
    Subl.with_logging(cmd = "tar cvfz #{File.join(dir,SUBL_TAR)} -C #{user_dir} Sublime\\ Text\\ 2") {command cmd}
  end
  notifies :run, "execute[push]"
end


execute "push" do
  Subl.with_logging(cmd = "cd #{File.dirname(__FILE__)}; git commit -a -m'update subl packages and settings'; git push") {command cmd}
  action :nothing
end

