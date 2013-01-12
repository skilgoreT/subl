require File.expand_path(File.join(File.dirname(__FILE__), 'subl'))

SUBL_TAR = "subl_2.0.1.tar"
FILES_DIR = File.expand_path(File.join(File.dirname(__FILE__),'../files'))


if platform?("ubuntu")

elsif platform?("mac_os_x")
  dir = File.join(FILES_DIR, 'mac_os_x')
  app_dir = File.join('/', 'Applications')
  tarball = File.join(dir, SUBL_TAR)
  Subl.with_logging(cmd = "tar cvf #{File.join(dir,SUBL_TAR)} -C #{app_dir} Sublime\\ Text\\ 2.app") {system cmd}
  dir = File.join(FILES_DIR, 'mac_os_x')
  user_dir = File.join(ENV['HOME'], 'Library', 'Application Support')
  Subl.with_logging(cmd = "tar rvf #{tarball} -C #{user_dir} 'Sublime Text 2'") {system cmd}
  Subl.with_logging(cmd = "gzip -f #{tarball}") {system cmd}  
  Subl.with_logging(cmd = "cd #{File.dirname(__FILE__)}; git commit -a -m'update subl packages and settings'; git push") {system cmd}
end




