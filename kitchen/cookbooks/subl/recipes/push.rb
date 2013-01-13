require File.expand_path(File.join(File.dirname(__FILE__), 'subl'))

SUBL_TAR = "subl_2.0.1.tar"
FILES_DIR = File.expand_path(File.join(File.dirname(__FILE__),'../files'))

if platform?("ubuntu")
    SUBL_USR = "sublime-text-2"
    SUBL_APP = "Sublime\\ Text\\ 2"
	tar_dir = File.join(FILES_DIR, 'ubuntu')
	tarball = File.join(tar_dir, SUBL_TAR)
	app_dir = File.join(ENV['HOME'], 'bin')
	usr_dir = File.join(ENV['HOME'], '.config')
elsif platform?("mac_os_x")
    SUBL_USR = "Sublime\\ Text\\ 2"
    SUBL_APP = "Sublime\\ Text\\ 2.app"
	tar_dir = File.join(FILES_DIR, 'mac_os_x')
	tarball = File.join(tar_dir, SUBL_TAR)
	usr_dir = File.join(ENV['HOME'], 'Library', 'Application\\ Support')
	app_dir = File.join('', 'Applications')
end

Subl.with_logging(cmd = "tar cvf #{File.join(tar_dir,SUBL_TAR)} -C #{app_dir} #{SUBL_APP}") {system cmd}
Subl.with_logging(cmd = "tar rvf #{tarball} -C #{usr_dir} #{SUBL_USR}") {system cmd}
Subl.with_logging(cmd = "gzip -f #{tarball}") {system cmd}  
Subl.with_logging(cmd = "cd #{File.dirname(__FILE__)}; git commit -a -m'update subl packages and settings'; git push") {system cmd}





